# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 16 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:16b}]
execute if score $bit rx.temp matches 16 run data remove storage rx:temp playerdb.filtered4[{bit4:16b}]

execute if score $bit rx.temp matches 17 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:17b}]
execute if score $bit rx.temp matches 17 run data remove storage rx:temp playerdb.filtered4[{bit4:17b}]

execute if score $bit rx.temp matches 18 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:18b}]
execute if score $bit rx.temp matches 18 run data remove storage rx:temp playerdb.filtered4[{bit4:18b}]

execute if score $bit rx.temp matches 19 run data modify storage rx:temp playerdb.filtered5 append from storage rx:temp playerdb.filtered4[{bit4:19b}]
execute if score $bit rx.temp matches 19 run data remove storage rx:temp playerdb.filtered4[{bit4:19b}]
