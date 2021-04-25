# By: rx97
# 24 Nov 20
# 
#> @s: player
#> Gets player name to rx:temp playerdb.name

#> at @s is loaded so win
execute unless entity e3241b58-07c0-5230-9794-aecdc5aaaad4 at @s run summon minecraft:armor_stand ~ ~ ~ {CustomName:'{"text":"PlayerDB Stand"}',NoGravity:1b,Silent:1b,Invulnerable:1b,UUID:[I;-484172968,130044464,-1751863603,-978670892],CustomNameVisible:0b,NoAI:1b,AbsorptionAmount:1e8f, Marker:1b, Small:1b, ShowArms:1b, Invisible:1b,Tags:["rx.playerdb"]}

#> get SkullOwner
loot replace entity e3241b58-07c0-5230-9794-aecdc5aaaad4 armor.head loot rx:player_head

#> copy to output
data modify storage rx:temp playerdb.player_name set from entity e3241b58-07c0-5230-9794-aecdc5aaaad4 ArmorItems[-1].tag.SkullOwner.Name

#> get rid of stand w/o killing it so the UUID is available
tp e3241b58-07c0-5230-9794-aecdc5aaaad4 ~ -2500 ~
