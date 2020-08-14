# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 12 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:12b}]
execute if score $bit rx.temp matches 13 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:13b}]
execute if score $bit rx.temp matches 14 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:14b}]
execute if score $bit rx.temp matches 15 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:15b}]