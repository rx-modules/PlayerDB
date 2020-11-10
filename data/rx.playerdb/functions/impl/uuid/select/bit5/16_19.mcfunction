# By: rx97
execute if score $bit rx.temp matches 16 if data storage rx:global playerdb.uuid[{bits:{b5:16b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:16b}}].bits.select set value 1b
execute if score $bit rx.temp matches 17 if data storage rx:global playerdb.uuid[{bits:{b5:17b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:17b}}].bits.select set value 1b
execute if score $bit rx.temp matches 18 if data storage rx:global playerdb.uuid[{bits:{b5:18b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:18b}}].bits.select set value 1b
execute if score $bit rx.temp matches 19 if data storage rx:global playerdb.uuid[{bits:{b5:19b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:19b}}].bits.select set value 1b