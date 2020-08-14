# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 8 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:8b}]
execute if score $bit rx.temp matches 8 run data remove storage rx:temp playerdb.filtered4[{bit4:8b}]
execute if score $bit rx.temp matches 9 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:9b}]
execute if score $bit rx.temp matches 9 run data remove storage rx:temp playerdb.filtered4[{bit4:9b}]
execute if score $bit rx.temp matches 10 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:10b}]
execute if score $bit rx.temp matches 10 run data remove storage rx:temp playerdb.filtered4[{bit4:10b}]
execute if score $bit rx.temp matches 11 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:11b}]
execute if score $bit rx.temp matches 11 run data remove storage rx:temp playerdb.filtered4[{bit4:11b}]