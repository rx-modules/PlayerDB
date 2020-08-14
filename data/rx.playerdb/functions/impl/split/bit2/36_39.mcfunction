# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 36 run data modify storage rx:temp playerdb.filtered3 append from storage rx:temp playerdb.filtered2[{bit2:36b}]
execute if score $bit rx.temp matches 36 run data remove storage rx:temp playerdb.filtered2[{bit2:36b}]

execute if score $bit rx.temp matches 37 run data modify storage rx:temp playerdb.filtered3 append from storage rx:temp playerdb.filtered2[{bit2:37b}]
execute if score $bit rx.temp matches 37 run data remove storage rx:temp playerdb.filtered2[{bit2:37b}]

execute if score $bit rx.temp matches 38 run data modify storage rx:temp playerdb.filtered3 append from storage rx:temp playerdb.filtered2[{bit2:38b}]
execute if score $bit rx.temp matches 38 run data remove storage rx:temp playerdb.filtered2[{bit2:38b}]

execute if score $bit rx.temp matches 39 run data modify storage rx:temp playerdb.filtered3 append from storage rx:temp playerdb.filtered2[{bit2:39b}]
execute if score $bit rx.temp matches 39 run data remove storage rx:temp playerdb.filtered2[{bit2:39b}]
