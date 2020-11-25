# By: rx97

scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:temp playerdb.bits.b0 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:temp playerdb.bits.b1 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:temp playerdb.bits.b2 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:temp playerdb.bits.b3 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:temp playerdb.bits.b4 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:temp playerdb.bits.b5 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:temp playerdb.bits.b6 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int

