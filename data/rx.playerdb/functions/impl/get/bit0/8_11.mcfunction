# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 8 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:8b}]
execute if score $bit rx.temp matches 9 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:9b}]
execute if score $bit rx.temp matches 10 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:10b}]
execute if score $bit rx.temp matches 11 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:11b}]