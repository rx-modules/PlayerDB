# By: shraavan97
# 24 Mar 2020
# 
#> Ticks.

scoreboard players add @a rx.time_played 0
execute as @a[scores={rx.time_played=..0}] run function rx:first_join
