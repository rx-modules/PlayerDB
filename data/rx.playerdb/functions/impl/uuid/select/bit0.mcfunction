# By: rx97
data modify storage rx:global playerdb.uuid[].bits.select set value 0b
scoreboard players operation $bit rx.temp = $uid rx.temp
scoreboard players operation $bit rx.temp %= $64 rx.int
scoreboard players set $size rx.temp 0
function rx.playerdb:impl/uuid/select/bit0/0_63
scoreboard players operation $uid rx.temp /= $64 rx.int
execute if data storage rx:global playerdb.uuid[{bits:{select:0b}}] data modify storage rx:global playerdb.uuid[{bits:{select:0b}}].selected set value 0b
execute if score $size rx.temp matches 2.. run function rx.playerdb:impl/uuid/select/bit1
