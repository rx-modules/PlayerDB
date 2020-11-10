# By: rx97
execute if score $bit rx.temp matches 0 if data storage rx:global playerdb.players[{bits:{b4:0b}}] run data modify storage rx:global playerdb.players[{bits:{b4:0b}}].bits.select set value 1b
execute if score $bit rx.temp matches 1 if data storage rx:global playerdb.players[{bits:{b4:1b}}] run data modify storage rx:global playerdb.players[{bits:{b4:1b}}].bits.select set value 1b
execute if score $bit rx.temp matches 2 if data storage rx:global playerdb.players[{bits:{b4:2b}}] run data modify storage rx:global playerdb.players[{bits:{b4:2b}}].bits.select set value 1b
execute if score $bit rx.temp matches 3 if data storage rx:global playerdb.players[{bits:{b4:3b}}] run data modify storage rx:global playerdb.players[{bits:{b4:3b}}].bits.select set value 1b