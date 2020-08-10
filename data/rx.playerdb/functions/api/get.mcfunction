# By: rx97
# 10 Aug 2020
# 
#> Get Data: Output in rx:output out.player

#define entity @s
#define storage rx:temp

data modify storage rx:temp playerdb set value {}

scoreboard players operation $uid rx.temp = $in.uid rx.io

function rx:playerdb/fast_filter
function rx:playerdb/_fast_get/bit0

execute store result score $uid rx.temp run data get storage rx:output playerdb.player.uid
execute unless score $uid rx.temp = $in.uid rx.io run data modify storage rx:output playerdb.player set value {}
