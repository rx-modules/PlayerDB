# By: rx97
# 21 Jul 2020
# 
#> Save data

data modify storage rx:temp playerdb set value {}
data modify storage rx:io playerdb.output.get.player set from storage rx:io playerdb.output.player
data modify storage rx:io playerdb.output.player set value {}

function rx:playerdb/internal_get

execute if data storage rx:io playerdb.output.player run data modify storage rx:io playerdb.output.leftover append from storage rx:io playerdb.output.get.player
data modify storage rx:global playerdb.players set from storage rx:io playerdb.output.leftover

data modify storage rx:output playerdb set value {}
