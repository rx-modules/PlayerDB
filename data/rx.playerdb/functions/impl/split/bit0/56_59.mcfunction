# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 56 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:56b}]
execute if score $bit rx.temp matches 56 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 57 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:57b}]
execute if score $bit rx.temp matches 57 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 58 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:58b}]
execute if score $bit rx.temp matches 58 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 59 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:59b}]
execute if score $bit rx.temp matches 59 run data remove rx:temp playerdb.filtered0