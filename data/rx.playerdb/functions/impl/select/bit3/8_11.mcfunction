# By: rx97
execute if score $bit rx.temp matches 8 if data storage rx:global playerdb.players[{bits:{b3:8b}}] run data modify storage rx:global playerdb.players[{bits:{b3:8b}}].bits.select set value 1b
execute if score $bit rx.temp matches 9 if data storage rx:global playerdb.players[{bits:{b3:9b}}] run data modify storage rx:global playerdb.players[{bits:{b3:9b}}].bits.select set value 1b
execute if score $bit rx.temp matches 10 if data storage rx:global playerdb.players[{bits:{b3:10b}}] run data modify storage rx:global playerdb.players[{bits:{b3:10b}}].bits.select set value 1b
execute if score $bit rx.temp matches 11 if data storage rx:global playerdb.players[{bits:{b3:11b}}] run data modify storage rx:global playerdb.players[{bits:{b3:11b}}].bits.select set value 1b