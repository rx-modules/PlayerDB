# By: rx97
# Generated on: 02 Nov 20

scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $2 rx.int
execute unless score $bit rx.temp matches 0 if data storage rx:global playerdb.players[{bit15:0b}] run data modify storage rx:global playerdb.players[{bit15:0b}].selected set value 0b
execute unless score $bit rx.temp matches 1 if data storage rx:global playerdb.players[{bit15:1b}] run data modify storage rx:global playerdb.players[{bit15:1b}].selected set value 0b
scoreboard players operation $uid rx.temp /= $2 rx.int
execute store result score $size rx.temp if data storage rx:global playerdb.players[{selected:1b}]
execute if score $size rx.temp matches 2.. run function rx.playerdb:impl/select/bit16
