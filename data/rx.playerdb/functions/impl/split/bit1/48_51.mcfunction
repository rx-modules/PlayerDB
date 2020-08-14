# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 48 run data modify storage rx:temp playerdb.filtered2 append from storage rx:temp playerdb.filtered1[{bit1:48b}]
execute if score $bit rx.temp matches 48 run data remove storage rx:temp playerdb.filtered1[{bit1:48b}]

execute if score $bit rx.temp matches 49 run data modify storage rx:temp playerdb.filtered2 append from storage rx:temp playerdb.filtered1[{bit1:49b}]
execute if score $bit rx.temp matches 49 run data remove storage rx:temp playerdb.filtered1[{bit1:49b}]

execute if score $bit rx.temp matches 50 run data modify storage rx:temp playerdb.filtered2 append from storage rx:temp playerdb.filtered1[{bit1:50b}]
execute if score $bit rx.temp matches 50 run data remove storage rx:temp playerdb.filtered1[{bit1:50b}]

execute if score $bit rx.temp matches 51 run data modify storage rx:temp playerdb.filtered2 append from storage rx:temp playerdb.filtered1[{bit1:51b}]
execute if score $bit rx.temp matches 51 run data remove storage rx:temp playerdb.filtered1[{bit1:51b}]
