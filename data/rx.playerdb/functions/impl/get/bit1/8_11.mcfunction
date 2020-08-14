# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 8 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:8b}]
execute if score $bit rx.temp matches 9 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:9b}]
execute if score $bit rx.temp matches 10 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:10b}]
execute if score $bit rx.temp matches 11 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:11b}]