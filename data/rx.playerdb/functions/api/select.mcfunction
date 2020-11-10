# By: rx97
# 26 Sept 20
# 
#> Select Data: Output selected:1b

#define entity @s

# set input
scoreboard players operation $uid rx.temp = $in.uid rx.io

# select
function rx.playerdb:impl/select
