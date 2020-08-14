# By: rx97
# 10 Aug 2020
# 
#> Add entry. Call w/ @s being the player

# used for player name
execute unless entity af-0-0-0-1 at @s run summon minecraft:armor_stand ~ ~ ~ {CustomName:'{"text":"PlayerDB Stand"}',NoGravity:1b,Silent:1b,Invulnerable:1b,UUID:[I;175,0,0,1],CustomNameVisible:0b,PersistenceRequired:1b,NoAI:1b,CanPickUpLoot:0b,AbsorptionAmount:1e8f, Marker:1b, Small:1b, ShowArms:1b, HandItems:[{"id":"minecraft:stick", Count:1b}]}

data modify storage rx:global playerdb.players append value {}
data remove entity aa-0-0-0-1 HandItems
loot replace entity aa-0-0-0-1 weapon.mainhand loot rx:player_head

execute store result storage rx:global playerdb.players[-1].uid int 1 run scoreboard players get @s rx.uid
data modify storage rx:global playerdb.players[-1].name set from entity aa-0-0-0-1 HandItems[0].tag.SkullOwner.Name
data modify storage rx:global playerdb.players[-1].UUID set from entity @s UUID
data modify storage rx:global playerdb.players[-1].bits set value {}
data modify storage rx:global playerdb.players[-1].data set value {}

scoreboard players operation $uid rx.temp = @s rx.uid
function rx.playerdb:impl/uid_to_bits

tag @s add rx.playerdb.HasEntry
