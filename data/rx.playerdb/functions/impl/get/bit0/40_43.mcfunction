# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 40 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:40b}]
execute if score $bit rx.temp matches 41 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:41b}]
execute if score $bit rx.temp matches 42 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:42b}]
execute if score $bit rx.temp matches 43 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:43b}]