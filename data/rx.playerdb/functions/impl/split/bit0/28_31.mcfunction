# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 28 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:28b}]
execute if score $bit rx.temp matches 28 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 29 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:29b}]
execute if score $bit rx.temp matches 29 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 30 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:30b}]
execute if score $bit rx.temp matches 30 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 31 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:31b}]
execute if score $bit rx.temp matches 31 run data remove rx:temp playerdb.filtered0