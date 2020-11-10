# By: rx97
execute if score $bit rx.temp matches 8 if data storage rx:global playerdb.uuid[{bits:{b1:8b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:8b}}].bits.select set value 1b
execute if score $bit rx.temp matches 9 if data storage rx:global playerdb.uuid[{bits:{b1:9b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:9b}}].bits.select set value 1b
execute if score $bit rx.temp matches 10 if data storage rx:global playerdb.uuid[{bits:{b1:10b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:10b}}].bits.select set value 1b
execute if score $bit rx.temp matches 11 if data storage rx:global playerdb.uuid[{bits:{b1:11b}}] run data modify storage rx:global playerdb.uuid[{bits:{b1:11b}}].bits.select set value 1b