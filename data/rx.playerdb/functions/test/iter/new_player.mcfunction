# By: rx97
# 24 Sept 20
# 
#> init storage

data modify storage rx:global iter.players append value {data:{}}

scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. run function rx.playerdb:test/iter/new_player
