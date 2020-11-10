# By: rx97
execute if score $bit rx.temp matches 40 if data storage rx:global playerdb.uuid[{bits:{b0:40b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:40b}}].bits.select set value 1b
execute if score $bit rx.temp matches 41 if data storage rx:global playerdb.uuid[{bits:{b0:41b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:41b}}].bits.select set value 1b
execute if score $bit rx.temp matches 42 if data storage rx:global playerdb.uuid[{bits:{b0:42b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:42b}}].bits.select set value 1b
execute if score $bit rx.temp matches 43 if data storage rx:global playerdb.uuid[{bits:{b0:43b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:43b}}].bits.select set value 1b