# By: rx97
# 21 Jul 2020
# 
#> Creates Objs. Called from #minecraft:load

# Lantern Load
scoreboard players set rx.playerdb load 1

# Internals
scoreboard objectives add rx.uid dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy
scoreboard objectives add rx.io dummy

execute unless score $uid.next rx.uid matches -2147483648.. run scoreboard players set $uid.next rx.uid 1

scoreboard players set $2 rx.int 2
scoreboard players set $3 rx.int 3
