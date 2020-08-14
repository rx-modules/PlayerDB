# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 60 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:60b}]
execute if score $bit rx.temp matches 60 run data remove storage rx:temp playerdb.filtered0[{bit0:60b}]
execute if score $bit rx.temp matches 61 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:61b}]
execute if score $bit rx.temp matches 61 run data remove storage rx:temp playerdb.filtered0[{bit0:61b}]
execute if score $bit rx.temp matches 62 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:62b}]
execute if score $bit rx.temp matches 62 run data remove storage rx:temp playerdb.filtered0[{bit0:62b}]
execute if score $bit rx.temp matches 63 run data modify storage rx:temp playerdb.filtered1 append from storage rx:temp playerdb.filtered0[{bit0:63b}]
execute if score $bit rx.temp matches 63 run data remove storage rx:temp playerdb.filtered0[{bit0:63b}]