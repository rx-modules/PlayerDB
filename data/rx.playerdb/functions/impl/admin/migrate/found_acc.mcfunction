# By: rx97
# 25 Apr 21
# 
#> @s: player
#> Once we've found the acc, migrate!

#> grab our uid and other data then nuke
execute store result score $migrate.uid rx.temp run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid
execute store result score $migrate.hasEntry rx.temp run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry
data modify storage rx:temp playerdb.admin.migrate.oldName set from storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name
data remove storage rx:global playerdb.uuid[{selected:1b}].entries[-1]

#> nuke our current entry if it exists
execute if score @s rx.pdb.HasEntry matches 1.. run scoreboard players operation $in.uid rx.io = @s rx.uid
execute if score @s rx.pdb.HasEntry matches 1.. run function rx.playerdb:api/select
execute if score @s rx.pdb.HasEntry matches 1.. run data remove storage rx:global playerdb.players[{selected:1b}]

#> restore our old uid and data
scoreboard players operation @s rx.uid = $migrate.uid rx.temp
scoreboard players operation @s rx.pdb.HasEntry = $migrate.hasEntry rx.temp

# also update name while we are at it
execute if score @s rx.pdb.HasEntry matches 1.. run function rx.playerdb:api/get_self
execute if score @s rx.pdb.HasEntry matches 1.. run data modify storage rx:global playerdb.players[{selected:1b}].info.UUID set from entity @s UUID
execute if score @s rx.pdb.HasEntry matches 1.. run function rx.playerdb:impl/get_name
execute if score @s rx.pdb.HasEntry matches 1.. run data modify storage rx:global playerdb.players[{selected:1b}].info.name set from storage rx:temp playerdb.player_name
execute if score @s rx.pdb.HasEntry matches 1.. run function rx.playerdb:api/save_self

#> update our current UUID entry w/ the original uid
scoreboard players operation $uid rx.temp = @s rx.uuid0
function rx.playerdb:impl/uuid/select
execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid byte 1 run scoreboard players get @s rx.uid
execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry byte 1 run scoreboard players get @s rx.pdb.HasEntry

#> tellraw a success msg :D
tellraw @a[tag=rx.admin] [{"text": "", "color": "green"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"storage": "rx:temp", "nbt": "playerdb.admin.migrate.oldName", "color": "gold"}, "'s data was migrated to ", {"selector": "@s", "color": "gold"}]
tellraw @s [{"text": "", "color": "green"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"storage": "rx:temp", "nbt": "playerdb.admin.migrate.oldName", "color": "gold"}, "'s data was successfully migrated to you!"]

#> cleanup
data remove storage rx:temp playerdb.admin.migrate
