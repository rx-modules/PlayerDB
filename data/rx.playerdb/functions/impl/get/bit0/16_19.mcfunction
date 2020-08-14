# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 16 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:16b}]
execute if score $bit rx.temp matches 17 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:17b}]
execute if score $bit rx.temp matches 18 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:18b}]
execute if score $bit rx.temp matches 19 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:19b}]