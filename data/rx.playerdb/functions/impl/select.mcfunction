# By: rx97
# 26 Sept 20
# 
#> Select Data: Output selected:1b

#define entity @s

# set input / reset temp
scoreboard players operation $uid rx.temp = $in.uid rx.io

# selection
execute if data storage rx:global playerdb.players[] run data modify storage rx:global playerdb.players[].selected set value 1b
execute if data storage rx:global playerdb.players[] run function rx.playerdb:impl/select/bit0
