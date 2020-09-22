# By: rx97
# 21 Sept 21 
# 
#> Replaces entry with @s
#> input:
#> * entry to replace : $in.uid rx.io
#> * entry replacing ^: @s rx.uid

# cache score
scoreboard players operation $admin rx.temp = $in.uid rx.io

# get current player and cache it
function rx.playerdb:api/get_self
data modify storage rx:io playerdb.current_player set from storage rx:io playerdb.player

# perform split with replacee's entry leaving leftover in temp
#> rx:io playerdb.player having a value ensures we found a player at that slot
scoreboard players operation $in.uid rx.io = $admin rx.temp
function rx.playerdb:impl/split

#> if we found an entry
# replace player with new data ;D
execute if data storage rx:io playerdb.player run data modify storage rx:io playerdb.player.data set from storage rx:io playerdb.current_player.data
execute if data storage rx:io playerdb.player run data modify storage rx:io playerdb.player.name set from storage rx:io playerdb.current_player.name
execute if data storage rx:io playerdb.player run data modify storage rx:io playerdb.player.UUID set from storage rx:io playerdb.current_player.UUID
execute if data storage rx:io playerdb.player run function rx.playerdb:impl/save
execute if data storage rx:io playerdb.player run tellraw @a[tag=rx.admin] {"text":"Player successfully replaced", "color": "gold"}
execute if data storage rx:io playerdb.player run scoreboard players operation @s rx.uid = $in.uid rx.io
#> else
execute unless data storage rx:io playerdb.player run tellraw @a[tag=rx.admin] {"text":"Player unsuccessfully replaced", "color": "#CE4257"}

# reset temp/others
data modify storage rx:temp playerdb set value {}
data remove storage rx:io playerdb.current_player
scoreboard players reset $admin rx.temp
