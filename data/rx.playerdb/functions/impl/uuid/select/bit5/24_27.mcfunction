# By: rx97
execute if score $bit rx.temp matches 24 if data storage rx:global playerdb.uuid[{bits:{b5:24b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:24b}}].bits.select set value 1b
execute if score $bit rx.temp matches 25 if data storage rx:global playerdb.uuid[{bits:{b5:25b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:25b}}].bits.select set value 1b
execute if score $bit rx.temp matches 26 if data storage rx:global playerdb.uuid[{bits:{b5:26b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:26b}}].bits.select set value 1b
execute if score $bit rx.temp matches 27 if data storage rx:global playerdb.uuid[{bits:{b5:27b}}] run data modify storage rx:global playerdb.uuid[{bits:{b5:27b}}].bits.select set value 1b