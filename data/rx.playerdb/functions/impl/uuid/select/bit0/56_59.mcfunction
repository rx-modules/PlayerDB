# By: rx97
execute if score $bit rx.temp matches 56 if data storage rx:global playerdb.uuid[{bits:{b0:56b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:56b}}].bits.select set value 1b
execute if score $bit rx.temp matches 57 if data storage rx:global playerdb.uuid[{bits:{b0:57b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:57b}}].bits.select set value 1b
execute if score $bit rx.temp matches 58 if data storage rx:global playerdb.uuid[{bits:{b0:58b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:58b}}].bits.select set value 1b
execute if score $bit rx.temp matches 59 if data storage rx:global playerdb.uuid[{bits:{b0:59b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:59b}}].bits.select set value 1b