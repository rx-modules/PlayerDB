# By: rx97
# 26 Sept 20
# 
#> Save data

#> Optimization
#> - Only call select if:
#> -: more than 1 selected:1b
#> -: uid of selected matches save uid
#> - If both the above are true, $size will be 1, else it will be 0
execute store result score $size rx.temp if data storage rx:global playerdb.players[{selected:1b}]
execute if score $size rx.temp matches 1 store result score $uid rx.temp run data get storage rx:io playerdb.player.info.uid
execute unless score $uid rx.temp = $in.uid rx.io run scoreboard players set $size rx.temp 0

#> Select if no optimization is possible
execute unless score $size rx.temp matches 1 run function rx.playerdb:impl/select

#> Execute a save
function rx.playerdb:impl/save
