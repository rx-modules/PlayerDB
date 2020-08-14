# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 0 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:0b}]
execute if score $bit rx.temp matches 0 run data remove storage rx:temp playerdb.filtered2[{bit2:0b}]
execute if score $bit rx.temp matches 1 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:1b}]
execute if score $bit rx.temp matches 1 run data remove storage rx:temp playerdb.filtered2[{bit2:1b}]
execute if score $bit rx.temp matches 2 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:2b}]
execute if score $bit rx.temp matches 2 run data remove storage rx:temp playerdb.filtered2[{bit2:2b}]
execute if score $bit rx.temp matches 3 run data modify storage rx:temp playerdb.filtered3 merge from storage rx:temp playerdb.filtered2[{bit2:3b}]
execute if score $bit rx.temp matches 3 run data remove storage rx:temp playerdb.filtered2[{bit2:3b}]