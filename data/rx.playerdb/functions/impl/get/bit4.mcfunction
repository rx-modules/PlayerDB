# By: rx97
# Generated on: 14 Aug 20

scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $64 rx.int
scoreboard players operation $uid rx.temp /= $64 rx.int
function rx.playerdb:impl/get/bit4/0_63
execute store result score $size rx.temp if data storage rx:temp playerdb.filtered4[]
execute if score $size rx.temp matches 0..1 run data modify storage rx:io playerdb.player set from storage rx:temp playerdb.filtered4[0]
execute if score $size rx.temp matches 2.. run function rx.playerdb:impl/get/bit5
