# By: rx97
# 14 Aug 20
# 
#> Creates Objs. Called from #minecraft:load

#define entity @s
#define storage rx:global
#define storage rx:temp
#define storage rx:io


# Rx Load
scoreboard players set PlayerDB load 1

scoreboard objectives add rx.uid dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy
scoreboard objectives add rx.io dummy
scoreboard objectives add rx.login minecraft.custom:minecraft.leave_game
scoreboard objectives add rx.List trigger
scoreboard objectives add rx.pdb.list dummy
scoreboard objectives add rx.pdb.HasEntry dummy

# uuid storage
scoreboard objectives add rx.uuid0 dummy
scoreboard objectives add rx.uuid1 dummy
scoreboard objectives add rx.uuid2 dummy
scoreboard objectives add rx.uuid3 dummy

execute unless score $uid.next rx.uid matches -2147483648.. run scoreboard players set $uid.next rx.uid 1

scoreboard players set $2 rx.int 2
scoreboard players set $3 rx.int 3
scoreboard players set $16 rx.int 16
scoreboard players set $19 rx.int 19
scoreboard players set $64 rx.int 64
scoreboard players set $256 rx.int 256

data modify storage rx:global playerdb.version.major set value 0
data modify storage rx:global playerdb.version.minor set value 8

schedule function rx.playerdb:tick 1t replace

tellraw @a[tag=rx.admin] {"text":"PlayerDB Loaded"}
