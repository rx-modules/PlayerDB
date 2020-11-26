# By: rx97
# 11 Nov 20
# 
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
