# By: rx97
# 21 Jul 2020
# 
#> Filters list

execute if score $uid rx.temp matches ..14348906 run data modify storage rx:temp playerdb.filtered append from storage rx:global playerdb.players[{bit15:0b, bit16:0b, bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 14348907..129140162 run data modify storage rx:temp playerdb.filtered append from storage rx:global playerdb.players[{bit17:0b, bit18:0b, bit19:0b}]
execute if score $uid rx.temp matches 129140163.. run data modify storage rx:temp playerdb.filtered append from storage rx:global playerdb.players
