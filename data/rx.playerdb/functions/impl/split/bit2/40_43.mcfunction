# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 40 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:40b}]
execute if score $bit rx.temp matches 40 run data remove storage rx:temp playerdb.filtered2[{bit2:40b}]
execute if score $bit rx.temp matches 41 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:41b}]
execute if score $bit rx.temp matches 41 run data remove storage rx:temp playerdb.filtered2[{bit2:41b}]
execute if score $bit rx.temp matches 42 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:42b}]
execute if score $bit rx.temp matches 42 run data remove storage rx:temp playerdb.filtered2[{bit2:42b}]
execute if score $bit rx.temp matches 43 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:43b}]
execute if score $bit rx.temp matches 43 run data remove storage rx:temp playerdb.filtered2[{bit2:43b}]