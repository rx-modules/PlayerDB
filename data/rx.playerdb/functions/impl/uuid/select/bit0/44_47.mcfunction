# By: rx97
execute if score $bit rx.temp matches 44 if data storage rx:global playerdb.uuid[{bits:{b0:44b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:44b}}].bits.select set value 1b
execute if score $bit rx.temp matches 45 if data storage rx:global playerdb.uuid[{bits:{b0:45b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:45b}}].bits.select set value 1b
execute if score $bit rx.temp matches 46 if data storage rx:global playerdb.uuid[{bits:{b0:46b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:46b}}].bits.select set value 1b
execute if score $bit rx.temp matches 47 if data storage rx:global playerdb.uuid[{bits:{b0:47b}}] run data modify storage rx:global playerdb.uuid[{bits:{b0:47b}}].bits.select set value 1b