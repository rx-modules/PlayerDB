# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 48 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:48b}]
execute if score $bit rx.temp matches 48 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 49 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:49b}]
execute if score $bit rx.temp matches 49 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 50 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:50b}]
execute if score $bit rx.temp matches 50 run data remove rx:temp playerdb.filtered0
execute if score $bit rx.temp matches 51 run data modify rx:temp playerdb.filtered1 set from storage rx:temp playerdb.filtered0[{bit0:51b}]
execute if score $bit rx.temp matches 51 run data remove rx:temp playerdb.filtered0