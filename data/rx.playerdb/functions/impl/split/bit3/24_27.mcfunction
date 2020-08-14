# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 24 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:24b}]
execute if score $bit rx.temp matches 24 run data remove rx:temp playerdb.filtered3
execute if score $bit rx.temp matches 25 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:25b}]
execute if score $bit rx.temp matches 25 run data remove rx:temp playerdb.filtered3
execute if score $bit rx.temp matches 26 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:26b}]
execute if score $bit rx.temp matches 26 run data remove rx:temp playerdb.filtered3
execute if score $bit rx.temp matches 27 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:27b}]
execute if score $bit rx.temp matches 27 run data remove rx:temp playerdb.filtered3