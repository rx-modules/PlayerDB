# By: rx97
execute if score $bit rx.temp matches 60 if data storage rx:global playerdb.uuid[{bits:{b2:60b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:60b}}].bits.select set value 1b
execute if score $bit rx.temp matches 61 if data storage rx:global playerdb.uuid[{bits:{b2:61b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:61b}}].bits.select set value 1b
execute if score $bit rx.temp matches 62 if data storage rx:global playerdb.uuid[{bits:{b2:62b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:62b}}].bits.select set value 1b
execute if score $bit rx.temp matches 63 if data storage rx:global playerdb.uuid[{bits:{b2:63b}}] run data modify storage rx:global playerdb.uuid[{bits:{b2:63b}}].bits.select set value 1b