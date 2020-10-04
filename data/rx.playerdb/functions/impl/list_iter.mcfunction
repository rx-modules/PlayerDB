# By: rx97
# 21 Jul 2020
# 
#> Iter

# tellraw
execute if score $iter rx.temp >= $min.iter rx.temp run tellraw @s [{"nbt":"playerdb.players[0].info.name", "storage":"rx:temp", "color": "gold"}, {"text": ": "}, {"nbt":"playerdb.players[0].info.uid", "storage":"rx:temp", "color": "#DAD6D6"}]

# iterate list
data remove storage rx:temp playerdb.players[0]

scoreboard players add $iter rx.temp 1

# ensure we don't over iterate
execute if data storage rx:temp playerdb.players[] if score $iter rx.temp < $max.iter rx.temp run function rx.playerdb:impl/list_iter
