# By: shraavan97
# 19 Nov 2019
# 
#> Filters list

execute if score $uid rx.temp matches ..242 run data modify storage rx:temp playerdb.filtered append from storage rx:global playerdb.players[{bit5:0b, bit6:0b, bit7:0b, bit8:0b, bit9:0b, bit10:0b, bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 243..728 run data modify storage rx:temp playerdb.filtered append from storage rx:global playerdb.players[{bit6:0b, bit7:0b, bit8:0b, bit9:0b, bit10:0b, bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 729..2186 run data modify storage rx:temp playerdb.filtered append from storage rx:global playerdb.players[{bit7:0b, bit8:0b, bit9:0b, bit10:0b, bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 2187.. run data modify storage rx:temp playerdb.filtered append from storage rx:global playerdb.players[{bit8:0b, bit9:0b, bit10:0b, bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
