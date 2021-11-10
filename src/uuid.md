<!-- Implement's uuid logic -->

## uuid/select

<details>

```mcfunction
# @function uuid/select

#> Select an entry in the UUID db
#> input -> $uid, output -> $found

scoreboard players set $found rx.temp 0

#> select UUID
execute store result score $uid rx.temp
	run data get storage rx.playerdb:temp UUID[0]

execute if data storage rx.playerdb:main uuid[] run sequentially
	data modify storage rx.playerdb:main uuid[].selected set value 1b
	function ./tree/bit0

#!for i in range(6)
#!function generate_path("uuid/tree/bit" ~ i)

data modify storage rx.playerdb:main uuid[].bits.select set value 0b
scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $64 rx.int
scoreboard players set $size rx.temp 0

#!for node in generate_tree(render_path, range(64))
#!function node.parent append
#!if node.partition(8)
execute if score $bit rx.temp matches {{ node.range }}
	run function {{ node.children }}
#!else
#!set path = "uuid[{selected:1b, bits:{b" ~ i ~ ":" ~ node.value ~ "b}}]"
execute
	if score $bit rx.temp matches {{ node.range }}
	if data storage rx.playerdb:main {{ path }}
	store result score $size rx.temp
	run data modify storage rx.playerdb:main {{ path }}.bits.select set value 1b
#!endif
#!endfunction
#!endfor

execute if data storage rx.playerdb:main uuid[{bits:{select:0b}}]
	run data modify storage rx.playerdb:main uuid[{bits:{select:0b}}].selected set value 0b

#!if not loop.last
scoreboard players operation $uid rx.temp /= $64 rx.int
execute if data storage rx.playerdb:main uuid[{selected:1b}] run function ./bit{{ i + 1 }}
#!endif

#!endfunction
#!endfor

#> selected or not
execute if data storage rx.playerdb:main uuid[{selected:1b}] run sequentially
	execute store result score $loop rx.temp
		if data storage rx.playerdb:main uuid[{selected:1b}].entries[]
	function ./iter
```

</details>

## uuid/iter

<details>

```mcfunction
# @function uuid/iter

#> iterate through all of the UUID entries

#> test
data modify storage rx.playerdb:temp UUIDTest set from storage rx.playerdb:main uuid[{selected:1b}].entries[-1].UUID
execute store success score $check rx.temp
	run data modify storage rx.playerdb:temp UUIDTest set from storage rx.playerdb:temp UUID

#> if $check == 1, entries DO NOT match
#> else if $check == 0, entries DO match
#> we just stop iterating if $check == 0, `[-1]` is the entry we care about!

#> iterate through entries unless we matched.
execute unless score $check rx.temp matches 0 run sequentially
	data modify storage rx.playerdb:main uuid[{selected:1b}].entries insert 0 from storage rx.playerdb:main uuid[{selected:1b}].entries[-1]
	data remove storage rx.playerdb:main uuid[{selected:1b}].entries[-1]

#> found!
execute if score $check rx.temp matches 0
	run scoreboard players set $found rx.temp 1

#> recurse
scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1..
	unless score $check rx.temp matches 0
	run function ./iter
```

</details>

## uuid/check

<details>

```mcfunction
# @function uuid/check

#> @s: player
#> Checks UUID score against nbt
#> Needed to chk if player renamed to old player name.
#> Will reset relevant scores if true and generate either new uid or old uid from system

#> get uuid into fakeplayer scores
data modify storage rx.playerdb:temp UUID set from entity @s UUID
execute store result score $uuid0 rx.temp run data get storage rx.playerdb:temp UUID[0]
execute store result score $uuid1 rx.temp run data get storage rx.playerdb:temp UUID[1]
execute store result score $uuid2 rx.temp run data get storage rx.playerdb:temp UUID[2]
execute store result score $uuid3 rx.temp run data get storage rx.playerdb:temp UUID[3]

#> select uuid since we'll need it later
scoreboard players operation $uid rx.temp = @s rx.uuid0
function ./select

#> get player name as we'll also need it later
function ../utils/get_name

#> chk if name is actually stored :P backwards compat !
execute unless data storage rx.playerdb:main uuid[{selected:1b}].entries[-1].name run
	data modify storage rx.playerdb:main uuid[{selected:1b}].entries[-1].name set from storage rx.playerdb:temp player_name

#> test fakeplayer against scoreboard scores
scoreboard players set $success rx.temp 0
execute
	if score $uuid0 rx.temp = @s rx.uuid0
	if score $uuid1 rx.temp = @s rx.uuid1
	if score $uuid2 rx.temp = @s rx.uuid2
	if score $uuid3 rx.temp = @s rx.uuid3
	run scoreboard players set $success rx.temp 1

#> if $success == 1:
#>   store name in UUID onto name in cache temp
#>   if copy succeeded:
#>     the name changed, 0 -> $success
#>   else:
#>     $success remains 1
execute if score $success rx.temp matches 1 run sequentially
	data modify storage rx.playerdb:temp name_cache set from storage rx.playerdb:temp player_name
	execute store result score $copy rx.temp
		run data modify storage rx.playerdb:temp name_cache set from storage rx.playerdb:main uuid[{selected:1b}].entries[-1].name
	execute if score $copy rx.temp matches 1
		run scoreboard players set $success rx.temp 0

#> elif $success == 0:
#>   name has changed!
#>   reset the scores like they should be and let's do our normal name change stuff
execute if score $success rx.temp matches 0 run commands resets
	scoreboard players reset @s rx.uid
	scoreboard players reset @s rx.playerdb.has_entry
	scoreboard players reset @s rx.uuid0
	scoreboard players reset @s rx.uuid1
	scoreboard players reset @s rx.uuid2
	scoreboard players reset @s rx.uuid3
	scoreboard players reset @s rx.playerdb.list_page 
	function ../set

scoreboard players reset @s rx.playerdb.counter
```

</details>

## uuid/new

<details>

```mcfunction
# @function uuid/new

#> @s: player
#> add new entry to uuid db

#> if selected
execute store result score $selected rx.temp if data storage rx.playerdb:main uuid[{selected:1b}] 

#> we are pretending to add an entry to players but we move it to uuid
execute if score $selected rx.temp matches 0 run sequentially
	scoreboard players operation $uid rx.temp = @s rx.uuid0
	function ../utils/uid_to_bits
	data modify storage rx.playerdb:main uuid append value {selected: 1b}
	data modify storage rx.playerdb:main uuid[-1].bits set from storage rx.playerdb:temp bits
	execute store result storage rx.playerdb:main uuid[-1].bits.uuid0 int 1
		run scoreboard players get @s rx.uuid0

function ../utils/get_name

#> other info
data modify storage rx.playerdb:main uuid[{selected:1b}].entries append value {}
execute store result storage rx.playerdb:main uuid[{selected:1b}].entries[-1].uid int 1 run scoreboard players get @s rx.uid
execute store result storage rx.playerdb:main uuid[{selected:1b}].entries[-1].has_entry byte 1 run scoreboard players get @s rx.playerdb.has_entry
data modify storage rx.playerdb:main uuid[{selected:1b}].entries[-1].name set from storage rx.playerdb:temp player_name 
data modify storage rx.playerdb:main uuid[{selected:1b}].entries[-1].UUID set from storage rx.playerdb:temp UUID

```

</details>

## uuid/set

<details>

```mcfunction
# @function uuid/set

#> @s: player
#> Set the uuid from storage

#> There are three situations for players w/o UUID:
#>   New player: no uid nor entry
#>   Returning player: no entry
#>   Returning player: has both uid and entry

#> get UUID from entity
data modify storage rx.playerdb:temp UUID set from entity @s UUID

#> store UUID in uuid0-3
execute store result score @s rx.uuid0 run data get storage rx.playerdb:temp UUID[0]
execute store result score @s rx.uuid1 run data get storage rx.playerdb:temp UUID[1]
execute store result score @s rx.uuid2 run data get storage rx.playerdb:temp UUID[2]
execute store result score @s rx.uuid3 run data get storage rx.playerdb:temp UUID[3]

#> select UUID + iterations
scoreboard players operation $uid rx.temp = @s rx.uuid0
function ./select

#> if not found:
#> 	gen a uid if we don't have one
#> 	gen a UUID entry since we don't have a UUID entry
execute if score $found rx.temp matches 0 run sequentially
	execute unless score @s rx.uid matches 1.. run function ../utils/new_uid
	function ./new

#> else: update! we have a name change!!
execute if score $found rx.temp matches 1 run
	function ./update
```

</details>

## uuid/update

<details>

```mcfunction
# @function uuid/update

#> @s: player
#> update UUID + PlayerDB w/ name change

#> else: cache our uid and our hasEntry
execute store result score $cache.uid rx.temp run
	data get storage rx.playerdb:main uuid[{selected:1b}].entries[-1].uid
execute store result score $cache.HasEntry rx.temp run
	data get storage rx.playerdb:main uuid[{selected:1b}].entries[-1].has_entry

#> apply cache
scoreboard players operation @s rx.uid = $cache.uid rx.temp
scoreboard players operation @s rx.playerdb.has_entry = $cache.HasEntry rx.temp

data modify storage rx.playerdb:io old_name set from storage rx.playerdb:main uuid[{selected:1b}].entries[-1].name

#> update name
execute if score @s rx.playerdb.has_entry matches 1 run sequentially
	function ../get/self
	function ../utils/get_name
	data modify storage rx.playerdb:main players[{selected:1b}].info.name set from storage rx.playerdb:temp player_name 
	function ../save/self

#> update name in uuid db
data modify storage rx.playerdb:main uuid[{selected:1b}].entries[-1].name set from storage rx.playerdb:temp player_name

#> admin :P
tellraw @a[tag=rx.admin] from rx.playerdb:api/name_change

#> api
execute if score @s rx.playerdb.has_entry matches 1 run data modify storage rx.playerdb:io player set from storage rx.playerdb:main players[{selected:1b}]
function #rx.playerdb:api/on_name_change
execute if score @s rx.playerdb.has_entry matches 1 run data modify storage rx.playerdb:main players[{selected:1b}].data set from storage rx.playerdb:io player.data

#> reapply cache
scoreboard players operation @s rx.uid = $cache.uid rx.temp
scoreboard players operation @s rx.playerdb.has_entry = $cache.HasEntry rx.temp
```

</details>
