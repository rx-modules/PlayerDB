# By: shraavan97
# 24 Mar 2020
# 
#> Ticks.

scoreboard players add @a rx.login 0
execute as @a[scores={rx.login=..0}] run function rx:playerdb/first_join
