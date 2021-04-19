# By: rx97

data modify storage rx:global playerdb.players[].bits.select set value 0b

scoreboard players operation $bit rx.temp = $uid rx.temp

scoreboard players operation $bit rx.temp %= $64 rx.int

scoreboard players set $size rx.temp 0

function rx.playerdb:impl/select/bit3/0_63

scoreboard players operation $uid rx.temp /= $64 rx.int

execute if data storage rx:global playerdb.players[{bits:{select:0b}}] run data modify storage rx:global playerdb.players[{bits:{select:0b}}].selected set value 0b

execute if score $size rx.temp matches 2.. run function rx.playerdb:impl/select/bit4
