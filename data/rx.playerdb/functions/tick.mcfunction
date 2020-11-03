# By: rx97
# 10 Aug 2020
# 
#> Checks Logins. Called from #minecraft:tick

scoreboard players enable @a rx.List
execute as @a run function rx.playerdb:player

schedule function rx.playerdb:tick 1t replace
