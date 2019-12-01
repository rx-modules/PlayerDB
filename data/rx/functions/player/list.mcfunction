# By: shraavan97
# 24 Nov 2019
# 
#> Lists all players...

tellraw @s [{"text":"UID: ", "color": "gold", "bold": "true"}, {"text": "Player", "color":"dark_aqua"}]
execute store result score $size rx.temp if data storage rx:global root.players[]
execute if score $size rx.temp matches 1.. run function rx:player/_list_iter
