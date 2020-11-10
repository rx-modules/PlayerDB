# By: rx97
execute if score $bit rx.temp matches 40 if data storage rx:global playerdb.uuid[{bits:{b5:40b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:40b}}].bits.select set value 1b
execute if score $bit rx.temp matches 41 if data storage rx:global playerdb.uuid[{bits:{b5:41b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:41b}}].bits.select set value 1b
execute if score $bit rx.temp matches 42 if data storage rx:global playerdb.uuid[{bits:{b5:42b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:42b}}].bits.select set value 1b
execute if score $bit rx.temp matches 43 if data storage rx:global playerdb.uuid[{bits:{b5:43b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:43b}}].bits.select set value 1b