# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 60 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:60b}]
execute if score $bit rx.temp matches 60 run data remove rx:temp playerdb.filtered1
execute if score $bit rx.temp matches 61 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:61b}]
execute if score $bit rx.temp matches 61 run data remove rx:temp playerdb.filtered1
execute if score $bit rx.temp matches 62 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:62b}]
execute if score $bit rx.temp matches 62 run data remove rx:temp playerdb.filtered1
execute if score $bit rx.temp matches 63 run data modify rx:temp playerdb.filtered2 set from storage rx:temp playerdb.filtered1[{bit1:63b}]
execute if score $bit rx.temp matches 63 run data remove rx:temp playerdb.filtered1