# By: shraavan97
# 14 Nov 2019
# 
#> Resets Storage. WARNING: CANNOT UNDO THIS OPERATION


scoreboard players reset * rx.uid
scoreboard players reset * rx.time_played
scoreboard players set $uid.next rx.uid 1

data modify storage rx:global root set value {}
data modify storage rx:output root set value {}
data modify storage rx:temp root set value {}

advancement revoke @a only rx:first_join
