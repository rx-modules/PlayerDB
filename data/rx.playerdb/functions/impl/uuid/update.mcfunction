# By: rx97
# 11 Nov 20
# 
#> @s: player
#> update UUID + PlayerDB w/ name change

#> else: grab our uid and our hasEntry
execute store result score @s rx.uid run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid
execute store result score @s rx.pdb.HasEntry run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry

#> update name, but this is ugly
execute if score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:api/get_self
execute if score @s rx.pdb.HasEntry matches 1 unless entity af-0-0-0-1 at @s run summon minecraft:armor_stand ~ ~ ~ {CustomName:'{"text":"PlayerDB Stand"}',NoGravity:1b,Silent:1b,Invulnerable:1b,UUID:[I;175,0,0,1],CustomNameVisible:0b,NoAI:1b,AbsorptionAmount:1e8f, Marker:1b, Small:1b, ShowArms:1b, Invisible:1b,Tags:['rx.pdb.stupid']}
execute if score @s rx.pdb.HasEntry matches 1 run loot replace entity af-0-0-0-1 armor.head loot rx:player_head
execute if score @s rx.pdb.HasEntry matches 1 run data modify storage rx:global playerdb.players[{selected:1b}].info.name set from entity af-0-0-0-1 ArmorItems[-1].tag.SkullOwner.Name
execute if score @s rx.pdb.HasEntry matches 1 as 000000af-0000-0000-0000-000000000001 if entity @s[tag=rx.pdb.stupid] run tp @s ~ -1000 ~
execute if score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:api/save_self

#> admin :P
tellraw @a[tag=rx.admin] [{"text": "", "color": "gray"}, {"nbt": "playerdb.pretty_name", "storage": "rx:info", "interpret": true}, ": ", {"selector": "@s"}, " has changed their name!"]
function #rx.playerdb:api/on_name_change
