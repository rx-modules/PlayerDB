# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 44 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:44b}]
execute if score $bit rx.temp matches 44 run data remove storage rx:temp playerdb.filtered4[{bit4:44b}]
execute if score $bit rx.temp matches 45 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:45b}]
execute if score $bit rx.temp matches 45 run data remove storage rx:temp playerdb.filtered4[{bit4:45b}]
execute if score $bit rx.temp matches 46 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:46b}]
execute if score $bit rx.temp matches 46 run data remove storage rx:temp playerdb.filtered4[{bit4:46b}]
execute if score $bit rx.temp matches 47 run data modify storage rx:temp playerdb.filtered5 merge from storage rx:temp playerdb.filtered4[{bit4:47b}]
execute if score $bit rx.temp matches 47 run data remove storage rx:temp playerdb.filtered4[{bit4:47b}]