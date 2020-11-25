# By: rx97
# 29 Oct 20
# 
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
function rx.playerdb:impl/uuid/select

#> get player name as we'll also need it later
function rx.playerdb:impl/get_name

#> chk if name is actually stored :P backwards compat !
execute unless data storage rx:global playerdb.uuid[{selected:1b}].name run data modify storage rx:global playerdb.uuid[{selected:1b}].name set from storage rx:temp playerdb.player_name

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
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uid
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.pdb.HasEntry
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid0
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid1
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid2
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid3
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.pdb.list 
execute if score $success rx.temp matches 0 run function rx.playerdb:impl/uuid/set

scoreboard players reset @s rx.pdb.login
