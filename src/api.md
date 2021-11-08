<!-- Implement's API -->

# API Version Checking

<details>

To allow PlayerDB to bundle, we must ensure we properly check the version to avoid multiple api functions being called at the same time. This means if two packs are using PlayerDB but one pack is using an older version, it will automatically call the newer version, unless there has been a major version change.

Clients of PlayerDB will call function tags as apart of the API which calls every single version of PlayerDB. We generate function stubs which only runs the api implementation if the version check passes. This ensures that older PlayerDB will not run if a newer one exists.

```mcfunction
execute
    if score #rx.playerdb.major load.status matches __major__
    if score #rx.playerdb.minor load.status matches __minor__
    if score #rx.playerdb.patch load.status matches __patch__
    run function ../api
```

```python
# @plugin

from beet import FunctionTag, Function, Context
import yaml

body = """
execute
    if score #rx.playerdb.major load.status matches {major}
    if score #rx.playerdb.minor load.status matches {minor}
    if score #rx.playerdb.patch load.status matches {patch}
    run function {func}/main
"""

api_calls = ["get", "get/self", "save", "save/self", "add_entry", "select"]

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
            body.format(
            	major=major, minor=minor, patch=patch, api=call,func=ctx.generate.path(call)),
            tags=[tag]
        )
    )
```

</details>

# api/get/main

<details>

```mcfunction
# @function get/main

#> Get Data: Output in rx:io out.player
#> TODO: make tellraws referenced from a file

execute if score $in.uid rx.playerdb.io < $uid.next rx.uid run sequentially
	function ../select/main
	function ./logic

#!function generate_path('get/logic')
# size leftover from select
execute if score $size rx.temp matches 1 run sequentially
	data modify storage rx.playerdb:io player set from storage rx.playerdb:main players[{selected:1b}]
	data remove storage rx.playerdb:io player.bits

execute if score $size rx.temp matches ..0 run
	data modify storage rx.playerdb:io player set value {}

# sanity check, output -> playerdb.player
execute store result score $uid rx.temp run
	data get storage rx.playerdb:io player.info.uid
execute unless score $uid rx.temp = $in.uid rx.playerdb.io run
	data modify storage rx.playerdb:io player set value {}
#!endfunction

execute if score $in.uid rx.playerdb.io >= $uid.next rx.uid run sequentially
	data remove storage rx.playerdb:io player
	tellraw @a[tag=rx.admin] {"text":"Unsuccessful get. Input uid above max uid", "color": "#CE4257"}
```

## get/self/main

```mcfunction
# @function get/self/main

#> Get @s Data: Output in rx:io out.player

#> api add_entry, won't add unless we need to. $entry: 1: we have entry, 0: we don't have entry
function ../../add_entry/main

scoreboard players operation $in.uid rx.playerdb.io = @s rx.uid
function ../../get/main
```

</details>

# api/save

<details>

## save/main

```mcfunction
# @function save/main

# optimization baked in
function ../select/main

# verify that rx:io is proper player
execute store result score $uid.check rx.temp
	run data get storage rx.playerdb:io player.info.uid

#> Execute a save if:
#> - data exists in rx:io
#> - data uid == input uid
#> Consume reguardless
execute unless data storage rx.playerdb:io player
	run tellraw @a[tag=rx.admin] {"text":"Save unsuccessful. No rx:io data to save.", "color": "#CE4257"}
execute if data storage rx.playerdb:io player
	unless score $uid.check rx.temp = $in.uid rx.playerdb.io
	run tellraw @a[tag=rx.admin] {"text":"Save unsuccessful. rx:io data uid invalid", "color": "#CE4257"}
execute if data storage rx.playerdb:io player
	if score $uid.check rx.temp = $in.uid rx.playerdb.io
	run function ./logic
data remove storage rx.playerdb:io player
```

## save/logic

```mcfunction
# @function save/logic

#> Save after Select

data modify storage rx.playerdb:main players[{selected:1b}].data set from storage rx.playerdb:io player.data
```

## save/self/main

```mcfunction
# @function save/self/main

#> Save @s Data

scoreboard players operation $in.uid rx.playerdb.io = @s rx.uid
function ../../save/main
```

</details>

# api/select

<details>

## select/main

```mcfunction
# @function select/main

#> Select Data: Output selected:1b

# set input
scoreboard players operation $uid rx.temp = $in.uid rx.playerdb.io

function ./logic
#!function generate_path('select/logic')

# verification
scoreboard players operation $verify.uid rx.playerdb.io = $uid rx.temp
function ../verify/main

# selection
execute if score $verified rx.playerdb.io matches 0 run sequentially
	execute unless data storage rx.playerdb:main players[]
		run tellraw @a[tag=rx.admin] {"text":"Selection failed. No players in database to select", "color": "#CE4257"}
	execute if data storage rx.playerdb:main players[] run sequentially
		data modify storage rx.playerdb:main players[].selected set value 1b
		tellraw @a {"nbt":"playerdb.players","storage":"rx:global"}
		function ./tree/bit0

#!for i in range(6)
#!function generate_path("select/tree/bit" ~ i)

data modify storage rx.playerdb:main players[].bits.select set value 0b
scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $64 rx.int
scoreboard players set $size rx.temp 0
tellraw @a ["$bit{{i}}:", {"score":{"name":"$bit","objective":"rx.temp"}}]

#!for node in generate_tree(render_path, range(64))
#!function node.parent append
#!if node.partition(8)
execute if score $bit rx.temp matches {{ node.range }}
	run function {{ node.children }}
#!else
#!set path = "players[{selected:1b, bits:{b" ~ i ~ ":" ~ node.value ~ "b}}]"
execute
	if score $bit rx.temp matches {{ node.range }}
	if data storage rx.playerdb:main {{ path }}
	run data modify storage rx.playerdb:main {{ path }}.bits.select set value 1b
#!endif
#!endfunction
#!endfor

tellraw @a ["$size:", {"score":{"name":"$size","objective":"rx.temp"}}]
execute
	if data storage rx.playerdb:main players[{bits:{select:0b}}]
	run data modify storage rx.playerdb:main players[{bits:{select:0b}}].selected set value 0b

#!if not loop.last
scoreboard players operation $uid rx.temp /= 64 rx.int
execute if score $size rx.temp matches 2.. run function ./bit{{ i + 1 }}
#!endif

#!endfunction
#!endfor
#!endfunction
```

</details>

# api/add_entry

<details>

```mcfunction
# @function add_entry/main

#!set major = ctx.meta.version.major

#> Add entry. Call w/ @s being the player

#> Fixes bug if player doesn't have uuid0 yet
function ../tick/player

#> Only run if @s doesn't have an entry
execute unless score @s rx.playerdb.has_entry matches 1 run function ./logic

#!function generate_path('add_entry/logic')
execute if data storage rx.playerdb:main players[]
	run data modify storage rx.playerdb:main players[].selected set value 0b

#> get name
function ../utils/get_name

#> add new entry
data modify storage rx.playerdb:main players append value {}

#> store sum data
execute store result storage rx.playerdb:main players[-1].info.uid int 1
	run scoreboard players get @s rx.uid
data modify storage rx.playerdb:main players[-1].info.name set from storage rx.playerdb:temp player_name 
data modify storage rx.playerdb:main players[-1].info.UUID set from entity @s UUID
data modify storage rx.playerdb:main players[-1].data set value {}
data modify storage rx.playerdb:main players[-1].selected set value 1b

#> generate bits :D
scoreboard players operation $uid rx.temp = @s rx.uid
function ../utils/uid_to_bits

#> copy bits
data modify storage rx.playerdb:main players[-1].bits set from storage rx.playerdb:temp bits

#> update uuidDB
data modify storage rx.playerdb:temp UUID set from storage rx.playerdb:main players[-1].info.UUID
function ../uuid/select
data modify storage rx.playerdb:main uuid[{selected:1b}].entries[-1].hasEntry set value 1b
scoreboard players set @s rx.playerdb.has_entry 1

#> api
data modify storage rx.playerdb:io player set from storage rx.playerdb:main players[{selected:1b}]
function #rx.playerdb:api/v{{ major ~ '/on_entry_add'}}
data modify storage rx.playerdb:main players[{selected:1b}].data set from storage rx.playerdb:io player.data
#!endfunction
```

</details>

# api/verify

<details>

```mcfunction
# @function verify/main

#> Verify selected is 1 and correct uid
#> input: $verify.uid rx.playerdb.io
#> output: $verified rx.playerdb.io 0/1 (0: failed, 1: success)

#> get size
execute store result score $size rx.temp
	if data storage rx.playerdb:main players[{selected:1b}]

#> get uid
execute store result score $uid.check rx.temp
	run data get storage rx.playerdb:main players[{selected:1b}].info.uid

#> stores 1 in $verified if:
#> - $size == 1
#> - $uid == $uid.check
execute store result score $verified rx.playerdb.io if score $size rx.temp matches 1
execute if score $verified rx.playerdb.io matches 1
	store result score $verified rx.playerdb.io if score $verify.uid rx.playerdb.io = $uid.check rx.temp

#> clean up
scoreboard players reset $uid.check rx.temp
```

</details>
