# By: shraavan97
# 14 Nov 2019
# 
#> First Join

scoreboard players set @s rx.login 1

scoreboard players operation @s rx.uid = $uid.next rx.uid

data modify storage rx:global playerdb.players append value {}
loot replace entity @s armor.head loot rx:player_head

execute store result storage rx:global playerdb.players[-1].uid int 1 run scoreboard players get @s rx.uid
data modify storage rx:global playerdb.players[-1].name set from entity @s Inventory[{Slot:103b}].tag.SkullOwner.Name
data modify storage rx:global playerdb.players[-1].head set from entity @s Inventory[{Slot:103b}]
data remove storage rx:global playerdb.players[-1].head.Slot

clear @s player_head{rx.player_head:1b}

scoreboard players operation $uid rx.temp = @s rx.uid
function rx:playerdb/uid_to_bits

scoreboard players add $uid.next rx.uid 1
