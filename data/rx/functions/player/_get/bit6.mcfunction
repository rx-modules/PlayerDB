# By: shraavan97
# 18 Nov 2019


scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $3 rx.int
execute if score $bit rx.temp matches 0 run data modify storage rx:temp root.filtered6 append from storage rx:temp root.filtered5[{bit6:0b}]
execute if score $bit rx.temp matches 0 run data modify storage rx:temp root.leftover append from storage rx:temp root.filtered5[{bit6:1b}]
execute if score $bit rx.temp matches 0 run data modify storage rx:temp root.leftover append from storage rx:temp root.filtered5[{bit6:2b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp root.filtered6 append from storage rx:temp root.filtered5[{bit6:1b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp root.leftover append from storage rx:temp root.filtered5[{bit6:0b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp root.leftover append from storage rx:temp root.filtered5[{bit6:2b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp root.filtered6 append from storage rx:temp root.filtered5[{bit6:2b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp root.leftover append from storage rx:temp root.filtered5[{bit6:0b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp root.leftover append from storage rx:temp root.filtered5[{bit6:1b}]
scoreboard players operation $uid rx.temp /= $3 rx.int
execute store result score $size rx.temp if data storage rx:temp root.filtered6[]
execute if score $size rx.temp matches 0..1 run data modify storage rx:output root.player set from storage rx:temp root.filtered6[0]
execute if score $size rx.temp matches 2.. run function rx:player/_get/bit7