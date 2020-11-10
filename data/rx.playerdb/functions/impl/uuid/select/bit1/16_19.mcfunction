# By: rx97
execute if score $bit rx.temp matches 16 if data storage rx:global playerdb.uuid[{bits:{b1:16b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:16b}}].bits.select set value 1b
execute if score $bit rx.temp matches 17 if data storage rx:global playerdb.uuid[{bits:{b1:17b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:17b}}].bits.select set value 1b
execute if score $bit rx.temp matches 18 if data storage rx:global playerdb.uuid[{bits:{b1:18b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:18b}}].bits.select set value 1b
execute if score $bit rx.temp matches 19 if data storage rx:global playerdb.uuid[{bits:{b1:19b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:19b}}].bits.select set value 1b