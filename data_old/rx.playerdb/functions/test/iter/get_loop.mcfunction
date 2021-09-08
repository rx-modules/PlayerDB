# By: rx97
# 24 Sept 20
# 
#> loop iter

data remove storage rx:temp iter.players[-1]
scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. run function rx.playerdb:test/iter/get_loop
