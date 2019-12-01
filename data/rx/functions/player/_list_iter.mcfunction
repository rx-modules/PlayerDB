# By: shraavan97
# 20 Nov 2019
# 
#> Iter

# tellraw
tellraw @s [{"nbt":"root.players[-1].uid", "storage":"rx:global", "color": "gold"}, {"text": ": "}, {"nbt":"root.players[-1].name", "storage":"rx:global", "color": "dark_aqua"}]

# iterate list
data modify storage rx:global root.players prepend from storage rx:global root.players[-1]
data remove storage rx:global root.players[-1]

# ensure we don't over iterate
scoreboard players remove $size rx.temp 1
execute if score $size rx.temp matches 1.. run function rx:player/_list_iter
