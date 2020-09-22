# By: rx97
# 14 Aug 20
# 
#> Creates Objs. Called from #minecraft:load

#define entity @s
#define storage rx:global
#define storage rx:temp
#define storage rx:io


# Lantern Load
scoreboard players set rx.playerdb load 1

scoreboard objectives add rx.uid dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy
scoreboard objectives add rx.io dummy

scoreboard objectives add rx.HasEntry dummy

execute unless score $uid.next rx.uid matches -2147483648.. run scoreboard players set $uid.next rx.uid 1
execute unless data storage rx:global playerdb.missing_uids run data modify storage rx:global playerd.missing_uids set value []

scoreboard players set $2 rx.int 2
scoreboard players set $3 rx.int 3
scoreboard players set $16 rx.int 16
scoreboard players set $64 rx.int 64
scoreboard players set $256 rx.int 256
