# By: rx97
execute if score $bit rx.temp matches 12 if data storage rx:global playerdb.players[{bits:{b5:12b}}] run data modify storage rx:global playerdb.players[{bits:{b5:12b}}].bits.select set value 1b
execute if score $bit rx.temp matches 13 if data storage rx:global playerdb.players[{bits:{b5:13b}}] run data modify storage rx:global playerdb.players[{bits:{b5:13b}}].bits.select set value 1b
execute if score $bit rx.temp matches 14 if data storage rx:global playerdb.players[{bits:{b5:14b}}] run data modify storage rx:global playerdb.players[{bits:{b5:14b}}].bits.select set value 1b
execute if score $bit rx.temp matches 15 if data storage rx:global playerdb.players[{bits:{b5:15b}}] run data modify storage rx:global playerdb.players[{bits:{b5:15b}}].bits.select set value 1b