# By: rx97
# 21 Jul 2020
# 
#> Iter

# tellraw
execute if score $iter rx.temp >= $min.iter rx.temp run tellraw @s [{"nbt":"playerdb.uuid[0].entries[0].name", "storage":"rx:temp", "color": "gold"}, {"text": ": "}, {"nbt":"playerdb.uuid[0].entries[0].uid", "storage":"rx:temp", "color": "#DAD6D6"}]

# iterate list
data remove storage rx:temp playerdb.uuid[0].entries[0]

scoreboard players add $iter rx.temp 1

# ensure we don't over iterate
execute if data storage rx:temp playerdb.uuid[0].entries[] if score $iter rx.temp < $max.iter rx.temp run function rx.playerdb:impl/admin/list/iter_entries
