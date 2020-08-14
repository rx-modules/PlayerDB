# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 40 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:40b}]
execute if score $bit rx.temp matches 40 run data remove rx:temp playerdb.filtered3
execute if score $bit rx.temp matches 41 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:41b}]
execute if score $bit rx.temp matches 41 run data remove rx:temp playerdb.filtered3
execute if score $bit rx.temp matches 42 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:42b}]
execute if score $bit rx.temp matches 42 run data remove rx:temp playerdb.filtered3
execute if score $bit rx.temp matches 43 run data modify rx:temp playerdb.filtered4 set from storage rx:temp playerdb.filtered3[{bit3:43b}]
execute if score $bit rx.temp matches 43 run data remove rx:temp playerdb.filtered3