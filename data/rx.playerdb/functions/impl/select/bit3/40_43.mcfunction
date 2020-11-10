# By: rx97
execute if score $bit rx.temp matches 40 if data storage rx:global playerdb.players[{bits:{b3:40b}}] run data modify storage rx:global playerdb.players[{bits:{b3:40b}}].bits.select set value 1b
execute if score $bit rx.temp matches 41 if data storage rx:global playerdb.players[{bits:{b3:41b}}] run data modify storage rx:global playerdb.players[{bits:{b3:41b}}].bits.select set value 1b
execute if score $bit rx.temp matches 42 if data storage rx:global playerdb.players[{bits:{b3:42b}}] run data modify storage rx:global playerdb.players[{bits:{b3:42b}}].bits.select set value 1b
execute if score $bit rx.temp matches 43 if data storage rx:global playerdb.players[{bits:{b3:43b}}] run data modify storage rx:global playerdb.players[{bits:{b3:43b}}].bits.select set value 1b