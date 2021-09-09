<!-- Implement's API -->

# API Version Checking

<details>

To allow PlayerDB to bundle, we must ensure we properly check the version to avoid multiple api functions being called at the same time. This means if two packs are using PlayerDB but one pack is using an older version, it will automatically call the newer version, unless there has been a major version change.

Clients of PlayerDB will call function tags as apart of the API which calls every single version of PlayerDB. We generate function stubs which only runs the api implementation if the version check passes. This ensures that older PlayerDB will not run if a newer one exists.

```mcfunction
execute
    if score #rx.pdb.major load.status matches __major__
    if score #rx.pdb.minor load.status matches __minor__
    if score #rx.pdb.patch load.status matches __patch__
    run function ../api
```

```python
# @plugin

from beet import FunctionTag, Function, Context
import yaml

body = """
execute
    if score #rx.pdb.major load.status matches {major}
    if score #rx.pdb.minor load.status matches {minor}
    if score #rx.pdb.patch load.status matches {patch}
    run function ../{api}
"""

api_calls = ["get", "get_self", "save", "save_self", "add_entry", "select"]

major, minor, patch = (
    ctx.meta["version"].major,
    ctx.meta["version"].minor,
    ctx.meta["version"].patch,
)

for call in api_calls:
    with ctx.override(generate_prefix=f"api/v{major}"):
        tag = ctx.generate(call, FunctionTag())
    ctx.generate(
        f"version_check/{call}",
        Function(
            body.format(major=major, minor=minor, patch=patch, api=call),
            tags=[tag]
        )
    )
```

</details>

# api/get

<details>

```mcfunction
# @function get

#> Get Data: Output in rx:io out.player
#> TODO: make tellraws referenced from a file

execute if score $in.uid rx.io < $uid.next rx.uid run sequentially
	function ./select
	function ./get/main

execute if score $in.uid rx.io >= $uid.next rx.uid run sequentially
	data remove storage rx:io playerdb.player
	tellraw @a[tag=rx.admin] {"text":"Unsuccessful get. Input uid above max uid", "color": "#CE4257"}
```

## get/main

```mcfunction
# @function get/main

#> Get Data: Output in rx:io out.player

# size leftover from select
execute if score $size rx.temp matches 1 run sequentially
	data modify storage rx:io playerdb.player set from storage rx:global playerdb.players[{selected:1b}]
	data remove storage rx:io playerdb.player.bits

execute if score $size rx.temp matches ..0 run data modify storage rx:io playerdb.player set value {}

# sanity check, output -> playerdb.player
execute store result score $uid rx.temp run data get storage rx:io playerdb.player.info.uid
execute unless score $uid rx.temp = $in.uid rx.io run data modify storage rx:io playerdb.player set value {}
```

```mcfunction
# @function get/self

#> Get @s Data: Output in rx:io out.player

#> api add_entry, won't add unless we need to. $entry: 1: we have entry, 0: we don't have entry
function ./add_entry

scoreboard players operation $in.uid rx.io = @s rx.uid
function ./get
```

</details>

# api/save

<details>

## save

```mcfunction
# @function save

# optimization baked in
function ./select

# verify that rx:io is proper player
execute store result score $uid.check rx.temp
	run data get storage rx:io playerdb.player.info.uid

#> Execute a save if:
#> - data exists in rx:io
#> - data uid == input uid
#> Consume reguardless
execute unless data storage rx:io playerdb.player
	run tellraw @a[tag=rx.admin] {"text":"Save unsuccessful. No rx:io data to save.", "color": "#CE4257"}
execute if data storage rx:io playerdb.player
	unless score $uid.check rx.temp = $in.uid rx.io
	run tellraw @a[tag=rx.admin] {"text":"Save unsuccessful. rx:io data uid invalid", "color": "#CE4257"}
execute if data storage rx:io playerdb.player
	if score $uid.check rx.temp = $in.uid rx.io
	run function save/main
data remove storage rx:io playerdb.player
```

## save/main

```mcfunction
# @function save/main

#> Save after Select

data modify storage rx:global playerdb.players[{selected:1b}].data set from storage rx:io playerdb.player.data
```

## save/self

```mcfunction
# @function save/self

#> Save @s Data

scoreboard players operation $in.uid rx.io = @s rx.uid
function ./save
```

</details>

# api/select

<details>

## select

```mcfunction
# @function select

#> Select Data: Output selected:1b

# set input
scoreboard players operation $uid rx.temp = $in.uid rx.io

# select
function ./select/main
```

## select/main

```mcfunction
# @function select/main

#> Select Data: Output selected:1b

scoreboard players operation $verify.uid rx.io = $uid rx.temp

# verification
function ./verify

# selection
execute if score $verified rx.io matches 0 run sequentially
	execute unless data storage rx:global playerdb.players[]
		run tellraw @a[tag=rx.admin] {"text":"Selection failed. No players in database to select", "color": "#CE4257"}
	execute if data storage rx:global playerdb.players[] run sequentially
		data modify storage rx:global playerdb.players[].selected set value 1b
		function ./select/tree/bit0
```

### bits generator
This plugin generates all of the bit checking logic.

```python
# @plugin

from beet import Function, Context
import math

BASE = 64
BRANCHES = 8
MAX_INT = 2 ** 31 - 1

ITERATIONS = math.log(MAX_INT, BASE) + 1


TREE = "execute if score $bit rx.temp matches {low}..{high} run function select/tree/bit{num}/{low}_{high}"

LEAF = "execute if score $bit rx.temp matches @ if data storage rx:global playerdb.players[{selected:1b, bits:{b%:@b}}] store result score $size rx.temp run data modify storage rx:global playerdb.players[{selected:1b, bits:{b%:@b}}].bits.select set value 1b"

def gen_bit(ctx: Context, bit_num: int):
    bit = (
        "data modify storage rx:global playerdb.players[].bits.select set value 0b\n"
        "scoreboard players operation $bit rx.temp = $uid rx.temp\n"
        f"scoreboard players operation $bit rx.temp %= ${BASE} rx.int\n"
        "scoreboard players set $size rx.temp 0\n"
        f"function select/tree/bit{bit_num}/0_{BASE-1}\n"
        f"scoreboard players operation $uid rx.temp /= ${BASE} rx.int\n"
        "execute if data storage rx:global playerdb.players[{bits:{select:0b}}] run data modify storage rx:global playerdb.players[{bits:{select:0b}}].selected set value 0b\n"
        f"execute if score $size rx.temp matches 2.. run function select/tree/bit{bit_num+1}\n"
    )
    ctx.generate(f"select/tree/bit{bit_num}", Function(bit))


def gen_tree(ctx: Context, bit_num: int, low: int, high: int):
    change = (high - low) // BRANCHES

    low_values = [low + change * i for i in range(BRANCHES)]
    high_values = [(low + change * (i + 1)) for i in range(BRANCHES)]

    values = list(zip(low_values, high_values))

    if low + BRANCHES < high:
        tree = tuple(
            TREE.format(low=value[0], high=value[1] - 1, num=bit_num)
            for value in values
        )

        ctx.generate(f"select/tree/bit{bit_num}/{low}_{high-1}", Function(tree))

        for value in values:
            gen_tree(ctx, bit_num, value[0], value[1])

    else:
        leaf = tuple(
            LEAF.replace("@", str(low + i)).replace("%", str(bit_num))
            for i in range(BRANCHES)
        )
        ctx.generate(f"select/tree/bit{bit_num}/{low}_{low+BRANCHES-1}", Function(leaf))

def main(ctx: Context):
    for i in range(int(ITERATIONS) + 1):
        gen_bit(ctx, i)
        gen_tree(ctx, i, 0, BASE)

main(ctx)
```

</details>

# api/add_entry

<details>

```mcfunction
# @function add_entry

#!set major = ctx.meta.version.major

#> Add entry. Call w/ @s being the player

#> Fixes bug if player doesn't have uuid0 yet
function ./player

#> Only run if @s doesn't have an entry
execute unless score @s rx.pdb.HasEntry matches 1 run commands main
	execute if data storage rx:global playerdb.players[]
		run data modify storage rx:global playerdb.players[].selected set value 0b

	#> get name
	function ../utils/get_name

	#> add new entry
	data modify storage rx:global playerdb.players append value {}

	#> store sum data
	execute store result storage rx:global playerdb.players[-1].info.uid int 1
		run scoreboard players get @s rx.uid
	data modify storage rx:global playerdb.players[-1].info.name set from storage rx:temp playerdb.player_name 
	data modify storage rx:global playerdb.players[-1].info.UUID set from entity @s UUID
	data modify storage rx:global playerdb.players[-1].data set value {}
	data modify storage rx:global playerdb.players[-1].selected set value 1b

	#> generate bits :D
	scoreboard players operation $uid rx.temp = @s rx.uid
	function ../utils/uid_to_bits

	#> copy bits
	data modify storage rx:global playerdb.players[-1].bits set from storage rx:temp playerdb.bits

	#> update uuidDB
	data modify storage rx:temp playerdb.UUID set from storage rx:global playerdb.players[-1].info.UUID
	function ../uuid/select
	data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry set value 1b
	scoreboard players set @s rx.pdb.HasEntry 1

	#> api
	data modify storage rx:io playerdb.player set from storage rx:global playerdb.players[{selected:1b}]
	function #rx.playerdb:api/v{{major}}/on_entry_add
	data modify storage rx:global playerdb.players[{selected:1b}].data set from storage rx:io playerdb.player.data
```

</details>

# api/verify

<details>

```mcfunction
# @function verify

#> Verify selected is 1 and correct uid
#> input: $verify.uid rx.io
#> output: $verified rx.io 0/1 (0: failed, 1: success)

#> get size
execute store result score $size rx.temp
	if data storage rx:global playerdb.players[{selected:1b}]

#> get uid
execute store result score $uid.check rx.temp
	run data get storage rx:global playerdb.players[{selected:1b}].info.uid

#> stores 1 in $verified if:
#> - $size == 1
#> - $uid == $uid.check
execute store result score $verified rx.temp if score $size rx.temp matches 1
execute if score $verified rx.temp matches 1
	store result score $verified rx.temp if score $verify.uid rx.temp = $uid.check rx.temp

#> clean up
scoreboard players reset $uid.check rx.temp
```

</details>
