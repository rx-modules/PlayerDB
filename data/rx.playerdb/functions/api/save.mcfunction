# By: rx97
# 21 Jul 2020
# 
#> Save data

data modify storage rx:temp playerdb set value {}
data modify storage rx:output playerdb.get.player set from storage rx:output playerdb.player
data modify storage rx:output playerdb.player set value {}

function rx:playerdb/internal_get

execute if data storage rx:output playerdb.player run data modify storage rx:output playerdb.leftover append from storage rx:output playerdb.get.player
data modify storage rx:global playerdb.players set from storage rx:output playerdb.leftover

data modify storage rx:output playerdb set value {}
