# By: shraavan97
# 19 Nov 2019
# 
#> Filters list

execute if score $uid rx.temp matches ..19682 run data modify storage rx:temp root.filtered append from storage rx:global root.players[{bit9:0b, bit10:0b, bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 19683..177146 run data modify storage rx:temp root.filtered append from storage rx:global root.players[{bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 177147.. run data modify storage rx:temp root.filtered append from storage rx:global root.players[{bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]

execute if score $uid rx.temp matches ..19682 run data modify storage rx:temp root.leftover append from storage rx:global root.players[{bit9:0b, bit10:0b, bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 19683..177146 run data modify storage rx:temp root.leftover append from storage rx:global root.players[{bit11:0b, bit12:0b, bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 177147.. run data modify storage rx:temp root.leftover append from storage rx:global root.players[{bit13:0b, bit14:0b, bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]

