# By: shraavan97
# 17 Nov 2019
# 
#> Save data

execute if data storage rx:output playerdb.player run data modify storage rx:output playerdb.leftover append from storage rx:output playerdb.player
data modify storage rx:global playerdb.players set from storage rx:output playerdb.leftover

data modify storage rx:output playerdb set value {}
