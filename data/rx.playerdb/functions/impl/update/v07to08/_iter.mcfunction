# By: rx97
# 09 Nov 20
# 
#> iterate

# input
execute store result score $uid rx.temp run data get storage rx:global playerdb.players[-1].info.uid

# purge
data remove storage rx:global playerdb.players[-1].bit0
data remove storage rx:global playerdb.players[-1].bit1
data remove storage rx:global playerdb.players[-1].bit2
data remove storage rx:global playerdb.players[-1].bit3
data remove storage rx:global playerdb.players[-1].bit4
data remove storage rx:global playerdb.players[-1].bit5
data remove storage rx:global playerdb.players[-1].bit6
data remove storage rx:global playerdb.players[-1].bit7
data remove storage rx:global playerdb.players[-1].bit8
data remove storage rx:global playerdb.players[-1].bit9
data remove storage rx:global playerdb.players[-1].bit10
data remove storage rx:global playerdb.players[-1].bit11
data remove storage rx:global playerdb.players[-1].bit12
data remove storage rx:global playerdb.players[-1].bit13
data remove storage rx:global playerdb.players[-1].bit14
data remove storage rx:global playerdb.players[-1].bit15
data remove storage rx:global playerdb.players[-1].bit16
data remove storage rx:global playerdb.players[-1].bit17
data remove storage rx:global playerdb.players[-1].bit18
data remove storage rx:global playerdb.players[-1].bit19
data remove storage rx:global playerdb.players[-1].bit20
data remove storage rx:global playerdb.players[-1].bit21
data remove storage rx:global playerdb.players[-1].bit22
data remove storage rx:global playerdb.players[-1].bit23
data remove storage rx:global playerdb.players[-1].bit24
data remove storage rx:global playerdb.players[-1].bit25
data remove storage rx:global playerdb.players[-1].bit26
data remove storage rx:global playerdb.players[-1].bit27
data remove storage rx:global playerdb.players[-1].bit28
data remove storage rx:global playerdb.players[-1].bit29
data remove storage rx:global playerdb.players[-1].bit30
data remove storage rx:global playerdb.players[-1].bit31

# gen updated bits
function rx.playerdb:impl/uid_to_bits

# iterate
scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. run data modify storage rx:global playerdb.players prepend from storage rx:global playerdb.players[-1]
execute if score $loop rx.temp matches 1.. run data remove storage rx:global playerdb.players[-1]
execute if score $loop rx.temp matches 1.. run function rx.playerdb:impl/update/v07to08/_iter
