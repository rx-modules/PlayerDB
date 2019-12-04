# By: shraavan97
# 24 Nov 2019
# 
#> Lists all players

data modify storage rx:temp playerdb set value {}

tellraw @s [{"text":"UID: ", "color": "gold", "bold": "true"}, {"text": "Player", "color":"dark_aqua"}]
execute if data storage rx:global playerdb.players run function rx:playerdb/_list_iter

data modify storage rx:global playerdb.players set from storage rx:temp playerdb.players
data remove storage rx:global playerdb.players[-1]
