# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 52 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:52b}]
execute if score $bit rx.temp matches 52 run data remove storage rx:temp playerdb.filtered3[{bit3:52b}]

execute if score $bit rx.temp matches 53 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:53b}]
execute if score $bit rx.temp matches 53 run data remove storage rx:temp playerdb.filtered3[{bit3:53b}]

execute if score $bit rx.temp matches 54 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:54b}]
execute if score $bit rx.temp matches 54 run data remove storage rx:temp playerdb.filtered3[{bit3:54b}]

execute if score $bit rx.temp matches 55 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:55b}]
execute if score $bit rx.temp matches 55 run data remove storage rx:temp playerdb.filtered3[{bit3:55b}]
