# By: rx97
execute if score $bit rx.temp matches 24 if data storage rx:global playerdb.players[{bits:{b4:24b}}] run data modify storage rx:global playerdb.players[{bits:{b4:24b}}].bits.select set value 1b
execute if score $bit rx.temp matches 25 if data storage rx:global playerdb.players[{bits:{b4:25b}}] run data modify storage rx:global playerdb.players[{bits:{b4:25b}}].bits.select set value 1b
execute if score $bit rx.temp matches 26 if data storage rx:global playerdb.players[{bits:{b4:26b}}] run data modify storage rx:global playerdb.players[{bits:{b4:26b}}].bits.select set value 1b
execute if score $bit rx.temp matches 27 if data storage rx:global playerdb.players[{bits:{b4:27b}}] run data modify storage rx:global playerdb.players[{bits:{b4:27b}}].bits.select set value 1b