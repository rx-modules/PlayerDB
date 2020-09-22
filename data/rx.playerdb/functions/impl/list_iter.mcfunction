# By: rx97
# 21 Jul 2020
# 
#> Iter

# tellraw
tellraw @s [{"nbt":"playerdb.players[-1].uid", "storage":"rx:temp", "color": "gold"}, {"text": ": "}, {"nbt":"playerdb.players[-1].name", "storage":"rx:temp", "color": "#CE4257"}]

# iterate list
data remove storage rx:temp playerdb.players[-1]

# ensure we don't over iterate
execute if data storage rx:temp playerdb.players[] run function rx.playerdb:impl/list_iter
