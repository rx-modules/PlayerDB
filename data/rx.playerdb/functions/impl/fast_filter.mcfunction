# By: rx97
# 21 Jul 2020
# 
#> Filters list, split @ 3**4

data modify storage rx:temp playerdb.filtered set value {}

execute if score $uid rx.temp matches ..80 run function rx:playerdb/_fast_filter/1_80
execute if score $uid rx.temp matches 81.. run function rx:playerdb/_fast_filter/81_
