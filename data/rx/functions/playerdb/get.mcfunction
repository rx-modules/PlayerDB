# By: shraavan97
# 17 Nov 2019
# 
#> Get Data: Output in rx:output out.player

#define entity @s

data modify storage rx:temp playerdb set value {}

scoreboard players operation $uid rx.temp = $in.uid rx.io

function rx:playerdb/filter
function rx:playerdb/_get/bit0

execute store result score $uid rx.temp run data get storage rx:output playerdb.player.uid
execute unless score $uid rx.temp = $in.uid rx.io run data modify storage rx:output playerdb.player set value {}
data modify storage rx:output playerdb.leftover set from storage rx:temp playerdb.leftover
