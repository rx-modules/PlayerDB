# By: rx97
execute if score $bit rx.temp matches 52 if data storage rx:global playerdb.players[{bits:{b0:52b}}] run data modify storage rx:global playerdb.players[{bits:{b0:52b}}].bits.select set value 1b
execute if score $bit rx.temp matches 53 if data storage rx:global playerdb.players[{bits:{b0:53b}}] run data modify storage rx:global playerdb.players[{bits:{b0:53b}}].bits.select set value 1b
execute if score $bit rx.temp matches 54 if data storage rx:global playerdb.players[{bits:{b0:54b}}] run data modify storage rx:global playerdb.players[{bits:{b0:54b}}].bits.select set value 1b
execute if score $bit rx.temp matches 55 if data storage rx:global playerdb.players[{bits:{b0:55b}}] run data modify storage rx:global playerdb.players[{bits:{b0:55b}}].bits.select set value 1b