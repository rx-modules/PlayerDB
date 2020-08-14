# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 4 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:4b}]
execute if score $bit rx.temp matches 5 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:5b}]
execute if score $bit rx.temp matches 6 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:6b}]
execute if score $bit rx.temp matches 7 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:7b}]