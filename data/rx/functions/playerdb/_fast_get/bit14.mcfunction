# By: shraavan97
# 20 Nov 2019


scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $3 rx.int
execute if score $bit rx.temp matches 0 run data modify storage rx:temp playerdb.filtered14 append from storage rx:temp playerdb.filtered13[{bit14:0b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp playerdb.filtered14 append from storage rx:temp playerdb.filtered13[{bit14:1b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp playerdb.filtered14 append from storage rx:temp playerdb.filtered13[{bit14:2b}]
scoreboard players operation $uid rx.temp /= $3 rx.int
execute store result score $size rx.temp if data storage rx:temp playerdb.filtered14[]
execute if score $size rx.temp matches 0..1 run data modify storage rx:output playerdb.player set from storage rx:temp playerdb.filtered14[0]
execute if score $size rx.temp matches 2.. run function rx:playerdb/_fast_get/bit15