# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 40 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:40b}]
execute if score $bit rx.temp matches 40 run data remove storage rx:temp playerdb.filtered4[{bit4:40b}]

execute if score $bit rx.temp matches 41 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:41b}]
execute if score $bit rx.temp matches 41 run data remove storage rx:temp playerdb.filtered4[{bit4:41b}]

execute if score $bit rx.temp matches 42 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:42b}]
execute if score $bit rx.temp matches 42 run data remove storage rx:temp playerdb.filtered4[{bit4:42b}]

execute if score $bit rx.temp matches 43 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:43b}]
execute if score $bit rx.temp matches 43 run data remove storage rx:temp playerdb.filtered4[{bit4:43b}]
