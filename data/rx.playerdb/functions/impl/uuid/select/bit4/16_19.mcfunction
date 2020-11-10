# By: rx97
execute if score $bit rx.temp matches 16 if data storage rx:global playerdb.uuid[{bits:{b4:16b}}] run data modify storage rx:global playerdb.uuid[{bits:{b4:16b}}].bits.select set value 1b
execute if score $bit rx.temp matches 17 if data storage rx:global playerdb.uuid[{bits:{b4:17b}}] run data modify storage rx:global playerdb.uuid[{bits:{b4:17b}}].bits.select set value 1b
execute if score $bit rx.temp matches 18 if data storage rx:global playerdb.uuid[{bits:{b4:18b}}] run data modify storage rx:global playerdb.uuid[{bits:{b4:18b}}].bits.select set value 1b
execute if score $bit rx.temp matches 19 if data storage rx:global playerdb.uuid[{bits:{b4:19b}}] run data modify storage rx:global playerdb.uuid[{bits:{b4:19b}}].bits.select set value 1b