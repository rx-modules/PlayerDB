# By: shraavan97
# 17 Nov 2019
# 
#> Get Data: Output in rx:output out.player

#define entity @s

scoreboard players operation $uid rx.temp = $in.uid rx.io

function rx:player/fast_filter
function rx:player/_fast_get/bit0

execute store result score $uid rx.temp run data get storage rx:output root.player.uid
execute unless score $uid rx.temp = $in.uid rx.io run data modify storage rx:output root.player set value {}
data modify storage rx:temp root set value {}
