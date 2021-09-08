<!-- Implement's uuid logic -->

## uuid/select

<details>

```mcfunction
# @function uuid/select

#> Select an entry in the UUID db
#> input -> $uid, output -> $found

scoreboard players set $found rx.temp 0

#> select UUID
execute store result score $uid rx.temp run data get storage rx:temp playerdb.UUID[0]
execute if data storage rx:global playerdb.uuid[] run commands
	data modify storage rx:global playerdb.uuid[].selected set value 1b
	function uuid/tree/bit0

#> selected or not
execute if data storage rx:global playerdb.uuid[{selected:1b}] store result score $loop rx.temp if data storage rx:global playerdb.uuid[{selected:1b}].entries[]
execute if data storage rx:global playerdb.uuid[{selected:1b}] run function uuid/iter
```

</details>

## uuid/iter

<details>

```mcfunction
# @function uuid/iter

#> iterate through all of the UUID entries

#> test
data modify storage rx:temp playerdb.UUIDTest set from storage rx:global playerdb.uuid[{selected:1b}].entries[-1].UUID
execute store success score $check rx.temp run data modify storage rx:temp playerdb.UUIDTest set from storage rx:temp playerdb.UUID

#> if $check == 1, entries DO NOT match
#> else if $check == 0, entries DO match
#> we just stop iterating if $check == 0, `[-1]` is the entry we care about!

#> iterate through entries unless we matched.
execute unless score $check rx.temp matches 0 run data modify storage rx:global playerdb.uuid[{selected:1b}].entries insert 0 from storage rx:global playerdb.uuid[{selected:1b}].entries[-1]
execute unless score $check rx.temp matches 0 run data remove storage rx:global playerdb.uuid[{selected:1b}].entries[-1]

#> found!
execute if score $check rx.temp matches 0 run scoreboard players set $found rx.temp 1

#> recurse
scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. unless score $check rx.temp matches 0 run function uuid/iter
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
data modify storage rx:temp playerdb.UUID set from entity @s UUID
execute store result score $uuid0 rx.temp run data get storage rx:temp playerdb.UUID[0]
execute store result score $uuid1 rx.temp run data get storage rx:temp playerdb.UUID[1]
execute store result score $uuid2 rx.temp run data get storage rx:temp playerdb.UUID[2]
execute store result score $uuid3 rx.temp run data get storage rx:temp playerdb.UUID[3]

#> select uuid since we'll need it later
scoreboard players operation $uid rx.temp = @s rx.uuid0
function uuid/select

#> get player name as we'll also need it later
function utils/get_name

#> chk if name is actually stored :P backwards compat !
execute unless data storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name run data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name set from storage rx:temp playerdb.player_name

#> test fakeplayer against scoreboard scores
scoreboard players set $success rx.temp 0
execute if score $uuid0 rx.temp = @s rx.uuid0 if score $uuid1 rx.temp = @s rx.uuid1 if score $uuid2 rx.temp = @s rx.uuid2 if score $uuid3 rx.temp = @s rx.uuid3 run scoreboard players set $success rx.temp 1

#> if $success == 1:
#>   store name in UUID onto name in cache temp
#>   if copy succeeded:
#>     the name changed, 0 -> $success
#>   else:
#>     $success remains 1
execute if score $success rx.temp matches 1 run data modify storage rx:temp playerdb.name_cache set from storage rx:temp playerdb.player_name
execute if score $success rx.temp matches 1 store result score $copy rx.temp run data modify storage rx:temp playerdb.name_cache set from storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name
execute if score $success rx.temp matches 1 if score $copy rx.temp matches 1 run scoreboard players set $success rx.temp 0

#> elif $success == 0:
#>   name has changed!
#>   reset the scores like they should be and let's do our normal name change stuff
execute if score $success rx.temp matches 0 run commands resets
	scoreboard players reset @s rx.uid
	scoreboard players reset @s rx.pdb.HasEntry
	scoreboard players reset @s rx.uuid0
	scoreboard players reset @s rx.uuid1
	scoreboard players reset @s rx.uuid2
	scoreboard players reset @s rx.uuid3
	scoreboard players reset @s rx.pdb.list 
	function rx.playerdb:impl/uuid/set

scoreboard players reset @s rx.pdb.login
```

</details>

## uuid/new

<details>

```mcfunction
# @function uuid/new

#> @s: player
#> add new entry to uuid db

#> if selected
execute store result score $selected rx.temp if data storage rx:global playerdb.uuid[{selected:1b}] 

#> we are pretending to add an entry to players but we move it to uuid
execute if score $selected rx.temp matches 0 run sequentially
	scoreboard players operation $uid rx.temp = @s rx.uuid0
	function rx.playerdb:impl/uid_to_bits
	data modify storage rx:global playerdb.uuid append value {selected: 1b}
	data modify storage rx:global playerdb.uuid[-1].bits set from storage rx:temp playerdb.bits
	execute store result storage rx:global playerdb.uuid[-1].bits.uuid0 int 1 run scoreboard players get @s rx.uuid0

function rx.playerdb:impl/get_name

#> other info
data modify storage rx:global playerdb.uuid[{selected:1b}].entries append value {}
execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid int 1 run scoreboard players get @s rx.uid
execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry byte 1 run scoreboard players get @s rx.pdb.HasEntry
data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name set from storage rx:temp playerdb.player_name 
data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].UUID set from storage rx:temp playerdb.UUID

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
data modify storage rx:temp playerdb.UUID set from entity @s UUID

#> store UUID in uuid0-3
execute store result score @s rx.uuid0 run data get storage rx:temp playerdb.UUID[0]
execute store result score @s rx.uuid1 run data get storage rx:temp playerdb.UUID[1]
execute store result score @s rx.uuid2 run data get storage rx:temp playerdb.UUID[2]
execute store result score @s rx.uuid3 run data get storage rx:temp playerdb.UUID[3]

#> select UUID + iterations
scoreboard players operation $uid rx.temp = @s rx.uuid0
function rx.playerdb:impl/uuid/select

#> if not found: gen a uid if we don't have one
execute if score $found rx.temp matches 0 unless score @s rx.uid matches 1.. run function rx.playerdb:impl/new_uid

#> gen a UUID entry since we don't have a UUID entry
execute if score $found rx.temp matches 0 run function rx.playerdb:impl/uuid/new

#> else: update! we have a name change!!
execute if score $found rx.temp matches 1 run function rx.playerdb:impl/uuid/update
```

</details>

## uuid/update

<details>

```mcfunction
# @function uuid/set

#> @s: player
#> update UUID + PlayerDB w/ name change

#> else: cache our uid and our hasEntry
execute store result score $cache.uid rx.temp run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid
execute store result score $cache.HasEntry rx.temp run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry

#> apply cache
scoreboard players operation @s rx.uid = $cache.uid rx.temp
scoreboard players operation @s rx.pdb.HasEntry = $cache.HasEntry rx.temp

#> update name
execute if score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:api/get_self
execute if score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:impl/get_name
execute if score @s rx.pdb.HasEntry matches 1 run data modify storage rx:io playerdb.old_name set from storage rx:global playerdb.players[{selected:1b}].info.name
execute if score @s rx.pdb.HasEntry matches 1 run data modify storage rx:global playerdb.players[{selected:1b}].info.name set from storage rx:temp playerdb.player_name 
execute if score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:api/save_self

#> update name in uuid db
data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name set from storage rx:temp playerdb.player_name

#> admin :P
tellraw @a[tag=rx.admin] [{"text": "", "color": "gray"}, {"nbt": "playerdb.pretty_name", "storage": "rx:info", "interpret": true}, ": ", {"storage": "rx:io", "nbt": "playerdb.old_name"}, " has changed their name to ", {"selector": "@s"}]

#> api
execute if score @s rx.pdb.HasEntry matches 1 run data modify storage rx:io playerdb.player set from storage rx:global playerdb.players[{selected:1b}]
function #rx.playerdb:api/on_name_change
execute if score @s rx.pdb.HasEntry matches 1 run data modify storage rx:global playerdb.players[{selected:1b}].data set from storage rx:io playerdb.player.data

#> reapply cache
scoreboard players operation @s rx.uid = $cache.uid rx.temp
scoreboard players operation @s rx.pdb.HasEntry = $cache.HasEntry rx.temp
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
data modify storage rx:temp playerdb.UUID set from entity @s UUID

#> store UUID in uuid0-3
execute store result score @s rx.uuid0 run data get storage rx:temp playerdb.UUID[0]
execute store result score @s rx.uuid1 run data get storage rx:temp playerdb.UUID[1]
execute store result score @s rx.uuid2 run data get storage rx:temp playerdb.UUID[2]
execute store result score @s rx.uuid3 run data get storage rx:temp playerdb.UUID[3]

#> select UUID + iterations
scoreboard players operation $uid rx.temp = @s rx.uuid0
function uuid/select

#> if not found
execute if score $found rx.temp matches 0 run sequentially
	#> gen a uid if we don't have one
	execute unless score @s rx.uid matches 1.. run function utils/new_uid

	#> gen a UUID entry since we don't have a UUID entry
	function uuid/new


#> else: update! we have a name change!!
execute if score $found rx.temp matches 1 run function uuid/update
```

</details>
