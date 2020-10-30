# By: rx97
# 10 Aug 2020
# 
#> Checks Logins. Called from #minecraft:tick

# give new uid's
# execute as @a unless score @s rx.uid matches 1.. run function rx.playerdb:impl/new_uid

# check if uuid0 has been set
execute as @a unless score @s rx.uuid0 = @s rx.uuid0 run function rx.playerdb:impl/uuid/set
execute as @a[scores={rx.login=1..}] run function rx.playerdb:impl/uuid/check

# list bullshit
scoreboard players enable @a rx.List
execute as @a[scores={rx.List=1..}] run function rx.playerdb:admin/list
execute as @a[scores={rx.List=..-1}] run function rx.playerdb:admin/list

schedule function rx.playerdb:tick 1t replace
