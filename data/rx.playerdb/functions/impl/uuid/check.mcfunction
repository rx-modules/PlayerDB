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

#> test fakeplayer against scoreboard scores
scoreboard players set $success rx.temp 0
execute if score $uuid0 rx.temp = @s rx.uuid0 if score $uuid1 rx.temp = @s rx.uuid1 if score $uuid2 rx.temp = @s rx.uuid2 if score $uuid3 rx.temp = @s rx.uuid3 run scoreboard players set $success rx.temp 1

#> if $success == 1:
#>   do nothing

#> elif $success == 0:
#>   name change!
#>   reset the scores like they should be and let's do our normal name change stuff
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uid
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.pdb.HasEntry
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid0
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid1
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid2
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.uuid3
execute if score $success rx.temp matches 0 run scoreboard players reset @s rx.pdb.list 
execute if score $success rx.temp matches 0 run function rx.playerdb:impl/uuid/set

scoreboard players set @s rx.login 0
