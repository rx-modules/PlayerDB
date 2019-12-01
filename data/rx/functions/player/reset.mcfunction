# By: shraavan97
# 14 Nov 2019
# 
#> Creates Objs. Called from #minecraft:load

scoreboard objectives add rx.constants dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy

scoreboard players reset * rx.uid
scoreboard players set $uid.next rx.uid 1

data modify storage rx:global root set value {}
data modify storage rx:output root set value {}
data modify storage rx:temp root set value {}

advancement revoke @a only rx:first_join
