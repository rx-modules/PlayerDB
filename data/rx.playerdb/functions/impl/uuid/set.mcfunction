# By: rx97
# 29 Oct 20
# 
#> @s: player
#> Set the uuid from storage

#> There are three situations for players w/o UUID:
#>   New player: no uid nor entry
#>   Returning player: no entry
#>   Returning player: has both uid and entry

#> get UUID from storage or entity
execute if score @s rx.pdb.HasEntry matches 1.. run function rx.playerdb:api/get_self
execute if score @s rx.pdb.HasEntry matches 1.. run data modify storage rx:temp playerdb.UUID set from storage rx:io playerdb.player.info.UUID
execute unless score @s rx.pdb.HasEntry matches 1.. run data modify storage rx:temp playerdb.UUID set from entity @s UUID

#> store UUID in uuid0-3
execute store result score @s rx.uuid0 run data get storage rx:temp playerdb.UUID[0]
execute store result score @s rx.uuid1 run data get storage rx:temp playerdb.UUID[1]
execute store result score @s rx.uuid2 run data get storage rx:temp playerdb.UUID[2]
execute store result score @s rx.uuid3 run data get storage rx:temp playerdb.UUID[3]

#> select UUID
execute if data storage rx:global playerdb.uuid[] run scoreboard players operation $uid rx.temp = @s rx.uuid0
execute if data storage rx:global playerdb.uuid[] run data modify storage rx:global playerdb.uuid[].selected set value 1b
execute if data storage rx:global playerdb.uuid[] run function rx.playerdb:impl/uuid/select/bit0

#> selected or not
execute unless data storage rx:global playerdb.uuid[{selected:1b}] run scoreboard players set $found rx.temp 0
execute if data storage rx:global playerdb.uuid[{selected:1b}] store result score $loop rx.temp if data storage rx:global playerdb.uuid[{selected:1b}].entries[]
execute if data storage rx:global playerdb.uuid[{selected:1b}] run function rx.playerdb:impl/uuid/iter

#> if not found: gen a uid if we don't have one
execute if score $found rx.temp matches 0 unless score @s rx.uid = @s rx.uid run function rx.playerdb:impl/new_uid

#> gen a UUID entry if we don't have a UUID entry
execute if score $found rx.temp matches 0 run function rx.playerdb:impl/uuid/new

#> else: grab our uid
execute if score $found rx.temp matches 1 store result score @s rx.uid run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid
