# By: rx97
execute if score $bit rx.temp matches 28 if data storage rx:global playerdb.players[{bits:{b0:28b}}] run data modify storage rx:global playerdb.players[{bits:{b0:28b}}].bits.select set value 1b
execute if score $bit rx.temp matches 29 if data storage rx:global playerdb.players[{bits:{b0:29b}}] run data modify storage rx:global playerdb.players[{bits:{b0:29b}}].bits.select set value 1b
execute if score $bit rx.temp matches 30 if data storage rx:global playerdb.players[{bits:{b0:30b}}] run data modify storage rx:global playerdb.players[{bits:{b0:30b}}].bits.select set value 1b
execute if score $bit rx.temp matches 31 if data storage rx:global playerdb.players[{bits:{b0:31b}}] run data modify storage rx:global playerdb.players[{bits:{b0:31b}}].bits.select set value 1b