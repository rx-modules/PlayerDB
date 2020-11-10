# By: rx97
execute if score $bit rx.temp matches 32 if data storage rx:global playerdb.uuid[{bits:{b3:32b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:32b}}].bits.select set value 1b
execute if score $bit rx.temp matches 33 if data storage rx:global playerdb.uuid[{bits:{b3:33b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:33b}}].bits.select set value 1b
execute if score $bit rx.temp matches 34 if data storage rx:global playerdb.uuid[{bits:{b3:34b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:34b}}].bits.select set value 1b
execute if score $bit rx.temp matches 35 if data storage rx:global playerdb.uuid[{bits:{b3:35b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:35b}}].bits.select set value 1b