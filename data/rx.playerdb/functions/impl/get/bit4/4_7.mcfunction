# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 4 run data modify rx:temp playerdb.filtered5 set from storage rx:temp playerdb.filtered4[{bit4:4b}]
execute if score $bit rx.temp matches 5 run data modify rx:temp playerdb.filtered5 set from storage rx:temp playerdb.filtered4[{bit4:5b}]
execute if score $bit rx.temp matches 6 run data modify rx:temp playerdb.filtered5 set from storage rx:temp playerdb.filtered4[{bit4:6b}]
execute if score $bit rx.temp matches 7 run data modify rx:temp playerdb.filtered5 set from storage rx:temp playerdb.filtered4[{bit4:7b}]