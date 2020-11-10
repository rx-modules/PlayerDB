# By: rx97
execute if score $bit rx.temp matches 52 if data storage rx:global playerdb.uuid[{bits:{b5:52b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:52b}}].bits.select set value 1b
execute if score $bit rx.temp matches 53 if data storage rx:global playerdb.uuid[{bits:{b5:53b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:53b}}].bits.select set value 1b
execute if score $bit rx.temp matches 54 if data storage rx:global playerdb.uuid[{bits:{b5:54b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:54b}}].bits.select set value 1b
execute if score $bit rx.temp matches 55 if data storage rx:global playerdb.uuid[{bits:{b5:55b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:55b}}].bits.select set value 1b