# By: rx97
execute if score $bit rx.temp matches 48 if data storage rx:global playerdb.uuid[{bits:{b2:48b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:48b}}].bits.select set value 1b
execute if score $bit rx.temp matches 49 if data storage rx:global playerdb.uuid[{bits:{b2:49b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:49b}}].bits.select set value 1b
execute if score $bit rx.temp matches 50 if data storage rx:global playerdb.uuid[{bits:{b2:50b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:50b}}].bits.select set value 1b
execute if score $bit rx.temp matches 51 if data storage rx:global playerdb.uuid[{bits:{b2:51b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:51b}}].bits.select set value 1b