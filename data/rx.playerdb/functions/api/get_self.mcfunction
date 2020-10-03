# By: rx97
# 24 Mar 2020
# 
#> Get Self Data

#> api add_entry, won't add unless we need to. $entry: 1: we have entry, 0: we don't have entry
execute store result score $entry rx.temp if score @s rx.pdb.HasEntry = @s rx.pdb.HasEntry
function rx.playerdb:api/add_entry

#> if: we just added an entry, select it
execute if score $entry rx.temp matches ..0 run data modify storage rx:global playerdb.players[].selected set value 0b
execute if score $entry rx.temp matches ..0 run data modify storage rx:global playerdb.players[-1].selected set value 1b

#> else: actually get
execute if score $entry rx.temp matches 1.. run scoreboard players operation $in.uid rx.io = @s rx.uid
execute if score $entry rx.temp matches 1.. run function rx.playerdb:api/get
