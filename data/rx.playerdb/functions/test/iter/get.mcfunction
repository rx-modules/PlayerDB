# By: rx97
# 15 Aug 20
# 
#> 1000 entries

scoreboard players operation $loop rx.temp = $n rx.temp

scoreboard players set @s random.min 1
scoreboard players operation @s random.range = $n rx.temp

function rx.playerdb:test/pdb/get_n
