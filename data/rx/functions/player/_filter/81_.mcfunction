# By: shraavan97
# 19 Nov 2019
# 
#> Filters list, split @ 3**8

execute if score $uid rx.temp matches 81..6560 run function rx:player/_filter/81_6560
execute if score $uid rx.temp matches 6561.. run function rx:player/_filter/6561_