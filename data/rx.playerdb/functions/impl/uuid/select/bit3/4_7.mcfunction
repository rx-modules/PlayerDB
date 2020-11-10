# By: rx97
execute if score $bit rx.temp matches 4 if data storage rx:global playerdb.uuid[{bits:{b3:4b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:4b}}].bits.select set value 1b
execute if score $bit rx.temp matches 5 if data storage rx:global playerdb.uuid[{bits:{b3:5b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:5b}}].bits.select set value 1b
execute if score $bit rx.temp matches 6 if data storage rx:global playerdb.uuid[{bits:{b3:6b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:6b}}].bits.select set value 1b
execute if score $bit rx.temp matches 7 if data storage rx:global playerdb.uuid[{bits:{b3:7b}}] run data modify storage rx:global playerdb.uuid[{bits:{b3:7b}}].bits.select set value 1b