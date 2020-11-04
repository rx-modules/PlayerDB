# By: rx97
# 10 Aug 2020
# 
#> Add entry. Call w/ @s being the player

execute if data storage rx:global playerdb.players[] run data modify storage rx:global playerdb.players[].selected set value 0b

#> summon stand
execute unless entity af-0-0-0-1 at @s run summon minecraft:armor_stand ~ ~ ~ {CustomName:'{"text":"PlayerDB Stand"}',NoGravity:1b,Silent:1b,Invulnerable:1b,UUID:[I;175,0,0,1],CustomNameVisible:0b,NoAI:1b,AbsorptionAmount:1e8f, Marker:1b, Small:1b, ShowArms:1b, Invisible:1b,Tags:['rx.pdb.stupid']}

#> add new entry
data modify storage rx:global playerdb.players append value {}

#> get head to get player name
loot replace entity af-0-0-0-1 armor.head loot rx:player_head

#> store sum data
execute store result storage rx:global playerdb.players[-1].info.uid int 1 run scoreboard players get @s rx.uid
data modify storage rx:global playerdb.players[-1].info.name set from entity af-0-0-0-1 ArmorItems[-1].tag.SkullOwner.Name
data modify storage rx:global playerdb.players[-1].info.UUID set from entity @s UUID
data modify storage rx:global playerdb.players[-1].data set value {}
data modify storage rx:global playerdb.players[-1].selected set value 1b

#> generate bits :D
scoreboard players operation $uid rx.temp = @s rx.uid
function rx.playerdb:impl/uid_to_bits

#> update uuidDB
data modify storage rx:temp playerdb.UUID set from storage rx:global playerdb.players[-1].info.UUID
function rx.playerdb:impl/uuid/select
data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry set value 1b
scoreboard players set @s rx.pdb.HasEntry 1

#> api
function #rx.playerdb:api/on_entry_add

#> better ? fml
execute as 000000af-0000-0000-0000-000000000001 if entity @s[tag=rx.pdb.stupid] run tp af-0-0-0-1 ~ -1000 ~
