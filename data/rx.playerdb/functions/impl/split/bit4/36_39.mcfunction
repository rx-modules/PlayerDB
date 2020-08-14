# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 36 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:36b}]
execute if score $bit rx.temp matches 36 run data remove storage rx:temp playerdb.filtered4[{bit4:36b}]
execute if score $bit rx.temp matches 37 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:37b}]
execute if score $bit rx.temp matches 37 run data remove storage rx:temp playerdb.filtered4[{bit4:37b}]
execute if score $bit rx.temp matches 38 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:38b}]
execute if score $bit rx.temp matches 38 run data remove storage rx:temp playerdb.filtered4[{bit4:38b}]
execute if score $bit rx.temp matches 39 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:39b}]
execute if score $bit rx.temp matches 39 run data remove storage rx:temp playerdb.filtered4[{bit4:39b}]