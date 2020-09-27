# By: rx97
# 26 Sept 20
# 
#> Select Data: Output selected:1b

#define entity @s

# set input / reset temp
scoreboard players operation $uid rx.temp = $in.uid rx.io

# selection
data modify storage rx:global playerdb.players[].selected set value 1b
function rx.playerdb:impl/select/bit0
