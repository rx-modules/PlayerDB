# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 8 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:8b}]
execute if score $bit rx.temp matches 9 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:9b}]
execute if score $bit rx.temp matches 10 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:10b}]
execute if score $bit rx.temp matches 11 run data modify storage rx:temp playerdb.filtered4 append from storage rx:temp playerdb.filtered3[{bit3:11b}]