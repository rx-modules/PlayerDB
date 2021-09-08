# By: rx97
# 29 Oct 20
# 
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
