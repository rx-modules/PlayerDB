# By: shraavan97
# 14 Nov 2019
# 
#> Creates Objs. Called from #minecraft:load

scoreboard objectives add rx.uid dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy
scoreboard objectives add rx.io dummy

scoreboard objectives add rx.leave_game minecraft.custom:minecraft.leave_game

scoreboard objectives add send trigger
scoreboard objectives add get_mail trigger
scoreboard objectives add check_mail trigger

execute unless score $uid.next rx.uid matches -2147483648.. run scoreboard players set $uid.next rx.uid 1

scoreboard players set $2 rx.int 2
scoreboard players set $3 rx.int 3
