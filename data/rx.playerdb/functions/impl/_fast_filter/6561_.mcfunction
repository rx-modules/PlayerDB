# By: rx97
# 21 Jul 2020
# 
#> Filters list, split @ 3**13

execute if score $uid rx.temp matches 6561..1594322 run function rx:playerdb/_fast_filter/6561_1594322
execute if score $uid rx.temp matches 1594323.. run function rx:playerdb/_fast_filter/1594323_