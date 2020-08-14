# By: rx97
# 21 Jul 2020
# 
#> Get Data: Output in rx:output out.player

#define entity @s

scoreboard players operation $uid rx.temp = $in.uid rx.io

function rx:playerdb/filter
data modify storage rx:temp playerdb set value {}
function rx:playerdb/_get/bit0

execute store result score $uid rx.temp run data get storage rx:output playerdb.player.uid
execute unless score $uid rx.temp = $in.uid rx.io run data modify storage rx:output playerdb.player set value {}
data modify storage rx:output playerdb.leftover set from storage rx:temp playerdb.leftover
