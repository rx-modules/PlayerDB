# By: shraavan97
# 14 Nov 2019
# 
#> Make the player entry

scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit0 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit0: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit1 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit1: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit2 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit2: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit3 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit3: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit4 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit4: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit5 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit5: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit6 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit6: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit7 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit7: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit8 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit8: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit9 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit9: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit10 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit10: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit11 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit11: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit12 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit12: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit13 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit13: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit14 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit14: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit15 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit15: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit16 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit16: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit17 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit17: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit18 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit18: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

scoreboard players operation $uid rx.temp /= $3 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit19 byte 1 run scoreboard players operation $bit rx.temp %= $3 rx.int
# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit19: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

