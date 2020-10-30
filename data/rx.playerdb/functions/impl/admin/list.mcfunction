# By: rx97
# 14 Aug 20
# 
#> Lists all players

#> Colors
# gold - primary
# #4F000B (rosewood) - secondary
# #720026 (claret), #CE4257 (brick red), #DAD6D6 (light gray) - accents

# @s rx.pdb.list : page number
# $iter          : current iter var
# $max.iter      : max iter value on page num
# $min.iter      : min iter value on page num
#> handles overflow/underflow
execute if score @s rx.pdb.list matches ..0 run scoreboard players set @s rx.pdb.list 1
execute store result score $length rx.temp if data storage rx:global playerdb.players[]
scoreboard players operation $max.iter rx.temp = @s rx.pdb.list
scoreboard players operation $max.iter rx.temp *= $16 rx.int
scoreboard players operation $min.iter rx.temp = $max.iter rx.temp
scoreboard players operation $min.iter rx.temp -= $16 rx.int
execute if score $max.iter rx.temp > $length rx.temp run scoreboard players set $max.iter rx.temp 19
execute if score $max.iter rx.temp matches 19 run scoreboard players set $min.iter rx.temp 0
execute if score $max.iter rx.temp matches 19 run scoreboard players set @s rx.pdb.list 1
scoreboard players set $iter rx.temp 0

data modify storage rx:temp playerdb.players set from storage rx:global playerdb.players

execute if data storage rx:temp playerdb.players run tellraw @s ["", {"text":"<<", "color": "#720026", "bold": true, "clickEvent": {"action": "run_command", "value": "/trigger rx.List set -1"}, "hoverEvent": {"action": "show_text", "value":{"text":"Click to navigate","color":"#DAD6D6"}}}, " ", {"text": "Player UID List", "color":"#CE4257"}, " ", {"text":">>", "color": "#720026", "bold": true, "hoverEvent": {"action": "show_text", "value":{"text":"Click to navigate","color":"#DAD6D6"}}, "clickEvent": {"action": "run_command", "value": "/trigger rx.List set 1"}}]
execute if data storage rx:temp playerdb.players run function rx.playerdb:admin/list_iter
execute unless data storage rx:temp playerdb.players run tellraw @s [{"text":"No players to list", "color":"#DAD6D6"}]

# cleanup
data modify storage rx:temp playerdb set value {}
