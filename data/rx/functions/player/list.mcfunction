# By: shraavan97
# 24 Nov 2019
# 
#> Lists all players

data modify storage rx:temp root set value {}

tellraw @s [{"text":"UID: ", "color": "gold", "bold": "true"}, {"text": "Player", "color":"dark_aqua"}]
execute if data storage rx:global root.players run function rx:player/_list_iter

data modify storage rx:global root.players set from storage rx:temp root.players
data remove storage rx:global root.players[-1]
