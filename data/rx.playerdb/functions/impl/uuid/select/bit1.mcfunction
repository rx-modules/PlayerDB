# By: rx97
data modify storage rx:global playerdb.uuid[].bits.select set value 0b
scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $64 rx.int
scoreboard players set $size rx.temp 0
function rx.playerdb:impl/uuid/select/bit1/0_63
scoreboard players operation $uid rx.temp /= $64 rx.int
execute if data storage rx:global playerdb.uuid[{bits:{select:0b}}] run data modify storage rx:global playerdb.uuid[{bits:{select:0b}}].selected set value 0b
execute if data storage rx:global playerdb.uuid[{selected:1b}] run function rx.playerdb:impl/uuid/select/bit2
