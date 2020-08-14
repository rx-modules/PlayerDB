# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 24 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:24b}]
execute if score $bit rx.temp matches 24 run data remove rx:temp playerdb.filtered2
execute if score $bit rx.temp matches 25 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:25b}]
execute if score $bit rx.temp matches 25 run data remove rx:temp playerdb.filtered2
execute if score $bit rx.temp matches 26 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:26b}]
execute if score $bit rx.temp matches 26 run data remove rx:temp playerdb.filtered2
execute if score $bit rx.temp matches 27 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:27b}]
execute if score $bit rx.temp matches 27 run data remove rx:temp playerdb.filtered2