# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 8 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:8b}]
execute if score $bit rx.temp matches 8 run data remove rx:temp playerdb.filtered2
execute if score $bit rx.temp matches 9 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:9b}]
execute if score $bit rx.temp matches 9 run data remove rx:temp playerdb.filtered2
execute if score $bit rx.temp matches 10 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:10b}]
execute if score $bit rx.temp matches 10 run data remove rx:temp playerdb.filtered2
execute if score $bit rx.temp matches 11 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:11b}]
execute if score $bit rx.temp matches 11 run data remove rx:temp playerdb.filtered2