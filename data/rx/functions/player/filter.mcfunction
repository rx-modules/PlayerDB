# By: shraavan97
# 19 Nov 2019
# 
#> Filters list, split @ 3**4

execute if score $uid rx.temp matches ..80 run function rx:player/_filter/1_80
execute if score $uid rx.temp matches 81.. run function rx:player/_filter/81_
