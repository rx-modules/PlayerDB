# By: rx97
# 14 Aug 20
# 
#> Make the player entry

scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit0 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int
tellraw @s[tag=rx.PDBDebug] [{"text":"", "color":"gold"}, {"text":"bit0: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit1 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int
tellraw @s[tag=rx.PDBDebug] [{"text":"", "color":"gold"}, {"text":"bit1: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit2 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int
tellraw @s[tag=rx.PDBDebug] [{"text":"", "color":"gold"}, {"text":"bit2: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit3 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int
tellraw @s[tag=rx.PDBDebug] [{"text":"", "color":"gold"}, {"text":"bit3: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]


scoreboard players operation $uid rx.temp /= $64 rx.int
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx:global playerdb.players[-1].bit4 byte 1 run scoreboard players operation $bit rx.temp %= $64 rx.int
tellraw @s[tag=rx.PDBDebug] [{"text":"", "color":"gold"}, {"text":"bit4: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]

