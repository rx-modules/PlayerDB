# By: shraavan97
# 20 Nov 2019
# 
#> Iter

# tellraw
tellraw @s [{"nbt":"playerdb.players[-1].uid", "storage":"rx:temp", "color": "gold"}, {"text": ": "}, {"nbt":"playerdb.players[-1].name", "storage":"rx:temp", "color": "dark_aqua"}]

# iterate list
data remove storage rx:temp playerdb.players[-1]

# ensure we don't over iterate
execute if data storage rx:temp playerdb.players[] run function rx:playerdb/_list_iter
