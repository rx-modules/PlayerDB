# By: rx97
execute if score $bit rx.temp matches 48 if data storage rx:global playerdb.players[{bits:{b1:48b}}] run data modify storage rx:global playerdb.players[{bits:{b1:48b}}].bits.select set value 1b
execute if score $bit rx.temp matches 49 if data storage rx:global playerdb.players[{bits:{b1:49b}}] run data modify storage rx:global playerdb.players[{bits:{b1:49b}}].bits.select set value 1b
execute if score $bit rx.temp matches 50 if data storage rx:global playerdb.players[{bits:{b1:50b}}] run data modify storage rx:global playerdb.players[{bits:{b1:50b}}].bits.select set value 1b
execute if score $bit rx.temp matches 51 if data storage rx:global playerdb.players[{bits:{b1:51b}}] run data modify storage rx:global playerdb.players[{bits:{b1:51b}}].bits.select set value 1b