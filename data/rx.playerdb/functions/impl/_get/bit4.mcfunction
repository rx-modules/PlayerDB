# By: rx97
# 21 Jul 2020


scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $3 rx.int
execute if score $bit rx.temp matches 0 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit4:0b}]
execute if score $bit rx.temp matches 0 run data modify storage rx:temp playerdb.leftover append from storage rx:temp playerdb.filtered3[{bit4:1b}]
execute if score $bit rx.temp matches 0 run data modify storage rx:temp playerdb.leftover append from storage rx:temp playerdb.filtered3[{bit4:2b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit4:1b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp playerdb.leftover append from storage rx:temp playerdb.filtered3[{bit4:0b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp playerdb.leftover append from storage rx:temp playerdb.filtered3[{bit4:2b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit4:2b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp playerdb.leftover append from storage rx:temp playerdb.filtered3[{bit4:0b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp playerdb.leftover append from storage rx:temp playerdb.filtered3[{bit4:1b}]
scoreboard players operation $uid rx.temp /= $3 rx.int
execute store result score $size rx.temp if data storage rx:temp playerdb.filtered4[]
execute if score $size rx.temp matches 0..1 run data modify storage rx:output playerdb.player set from storage rx:temp playerdb.filtered4[0]
execute if score $size rx.temp matches 2.. run function rx:playerdb/_get/bit5