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

#> else: grab our uid and our hasEntry
execute if score $found rx.temp matches 1 store result score @s rx.uid run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid
execute if score $found rx.temp matches 1 store result score @s rx.pdb.HasEntry run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry

#> update name, but this is ugly
execute if score $found rx.temp matches 1 if score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:api/get_self
execute if score $found rx.temp matches 1 if score @s rx.pdb.HasEntry matches 1 unless entity af-0-0-0-1 at @s run summon minecraft:armor_stand ~ ~ ~ {CustomName:'{"text":"PlayerDB Stand"}',NoGravity:1b,Silent:1b,Invulnerable:1b,UUID:[I;175,0,0,1],CustomNameVisible:0b,NoAI:1b,AbsorptionAmount:1e8f, Marker:1b, Small:1b, ShowArms:1b, Invisible:1b,Tags:['rx.pdb.stupid']}
execute if score $found rx.temp matches 1 if score @s rx.pdb.HasEntry matches 1 run loot replace entity af-0-0-0-1 armor.head loot rx:player_head
execute if score $found rx.temp matches 1 if score @s rx.pdb.HasEntry matches 1 run data modify storage rx:global playerdb.players[{selected:1b}].info.name set from entity af-0-0-0-1 ArmorItems[-1].tag.SkullOwner.Name
execute if score $found rx.temp matches 1 if score @s rx.pdb.HasEntry matches 1 as 000000af-0000-0000-0000-000000000001 if entity @s[tag=rx.pdb.stupid] run tp @s ~ -1000 ~
execute if score $found rx.temp matches 1 if score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:api/save_self

#> admin :P
execute if score $found rx.temp matches 1 run tellraw @a[tag=rx.admin] ["", {"selector": "@s"}, " has changed their name!"]
execute if score $found rx.temp matches 1 run function #rx.playerdb:api/on_name_change
