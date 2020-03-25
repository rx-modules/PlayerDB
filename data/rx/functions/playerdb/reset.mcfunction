# By: shraavan97
# 14 Nov 2019
# 
#> Resets Storage. WARNING: CANNOT UNDO THIS OPERATION


scoreboard players reset * rx.uid
scoreboard players reset * rx.login
scoreboard players set $uid.next rx.uid 1

data modify storage rx:global playerdb set value {}
data modify storage rx:output playerdb set value {}
data modify storage rx:temp playerdb set value {}
