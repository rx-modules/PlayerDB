# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 0 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:0b}]
execute if score $bit rx.temp matches 1 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:1b}]
execute if score $bit rx.temp matches 2 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:2b}]
execute if score $bit rx.temp matches 3 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:3b}]