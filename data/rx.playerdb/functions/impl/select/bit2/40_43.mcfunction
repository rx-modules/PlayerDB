# By: rx97
execute if score $bit rx.temp matches 40 if data storage rx:global playerdb.players[{bits:{b2:40b}}] run data modify storage rx:global playerdb.players[{bits:{b2:40b}}].bits.select set value 1b
execute if score $bit rx.temp matches 41 if data storage rx:global playerdb.players[{bits:{b2:41b}}] run data modify storage rx:global playerdb.players[{bits:{b2:41b}}].bits.select set value 1b
execute if score $bit rx.temp matches 42 if data storage rx:global playerdb.players[{bits:{b2:42b}}] run data modify storage rx:global playerdb.players[{bits:{b2:42b}}].bits.select set value 1b
execute if score $bit rx.temp matches 43 if data storage rx:global playerdb.players[{bits:{b2:43b}}] run data modify storage rx:global playerdb.players[{bits:{b2:43b}}].bits.select set value 1b