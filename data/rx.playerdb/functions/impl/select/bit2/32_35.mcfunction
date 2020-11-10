# By: rx97
execute if score $bit rx.temp matches 32 if data storage rx:global playerdb.players[{bits:{b2:32b}}] run data modify storage rx:global playerdb.players[{bits:{b2:32b}}].bits.select set value 1b
execute if score $bit rx.temp matches 33 if data storage rx:global playerdb.players[{bits:{b2:33b}}] run data modify storage rx:global playerdb.players[{bits:{b2:33b}}].bits.select set value 1b
execute if score $bit rx.temp matches 34 if data storage rx:global playerdb.players[{bits:{b2:34b}}] run data modify storage rx:global playerdb.players[{bits:{b2:34b}}].bits.select set value 1b
execute if score $bit rx.temp matches 35 if data storage rx:global playerdb.players[{bits:{b2:35b}}] run data modify storage rx:global playerdb.players[{bits:{b2:35b}}].bits.select set value 1b