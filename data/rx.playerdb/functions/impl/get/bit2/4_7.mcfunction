# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 4 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:4b}]
execute if score $bit rx.temp matches 5 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:5b}]
execute if score $bit rx.temp matches 6 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:6b}]
execute if score $bit rx.temp matches 7 run data modify rx:temp playerdb.filtered3 set from storage rx:temp playerdb.filtered2[{bit2:7b}]