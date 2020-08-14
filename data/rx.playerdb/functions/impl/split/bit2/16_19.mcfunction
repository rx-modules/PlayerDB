# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 16 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:16b}]
execute if score $bit rx.temp matches 16 run data remove storage rx:temp playerdb.filtered2[{bit2:16b}]
execute if score $bit rx.temp matches 17 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:17b}]
execute if score $bit rx.temp matches 17 run data remove storage rx:temp playerdb.filtered2[{bit2:17b}]
execute if score $bit rx.temp matches 18 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:18b}]
execute if score $bit rx.temp matches 18 run data remove storage rx:temp playerdb.filtered2[{bit2:18b}]
execute if score $bit rx.temp matches 19 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:19b}]
execute if score $bit rx.temp matches 19 run data remove storage rx:temp playerdb.filtered2[{bit2:19b}]