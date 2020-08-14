# By: rx97
# 21 Jul 2020
# 
#> Resets Storage. WARNING: CANNOT UNDO THIS OPERATION

#define storage rx:global
#define storage rx:output
#define storage rx:temp

scoreboard players reset * rx.uid
scoreboard players set $uid.next rx.uid 1

data modify storage rx:global playerdb set value {}
data modify storage rx:output playerdb set value {}
data modify storage rx:temp playerdb set value {}
