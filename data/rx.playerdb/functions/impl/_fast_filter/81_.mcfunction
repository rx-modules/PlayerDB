# By: rx97
# 21 Jul 2020
# 
#> Filters list, split @ 3**8

execute if score $uid rx.temp matches 81..6560 run function rx:playerdb/_fast_filter/81_6560
execute if score $uid rx.temp matches 6561.. run function rx:playerdb/_fast_filter/6561_