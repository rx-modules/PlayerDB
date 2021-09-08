# By: rx97
# 14 Aug 20
# 
#> Get n times

scoreboard players set $max random 200
scoreboard players set $min random 1
function rx.playerdb:test/random

scoreboard players operation $loop rx.temp = $output random
data modify storage rx:temp iter.players set from storage rx:global iter.players
function rx.playerdb:test/iter/get_loop

data modify storage rx:io iter.output set from storage rx:temp iter.players[-1]
