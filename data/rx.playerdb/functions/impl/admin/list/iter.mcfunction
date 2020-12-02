# By: rx97
# 21 Jul 2020
# 
#> Iter

function rx.playerdb:impl/admin/list/iter_entries

# iterate list
data remove storage rx:temp playerdb.uuid[0]

# ensure we don't over iterate
execute if data storage rx:temp playerdb.uuid[] if score $iter rx.temp < $max.iter rx.temp run function rx.playerdb:impl/admin/list/iter