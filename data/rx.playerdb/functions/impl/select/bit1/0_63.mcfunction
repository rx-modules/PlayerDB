# By: rx97
execute if score $bit rx.temp matches 0..7 run function rx.playerdb:impl/select/bit1/0_7
execute if score $bit rx.temp matches 8..15 run function rx.playerdb:impl/select/bit1/8_15
execute if score $bit rx.temp matches 16..23 run function rx.playerdb:impl/select/bit1/16_23
execute if score $bit rx.temp matches 24..31 run function rx.playerdb:impl/select/bit1/24_31
execute if score $bit rx.temp matches 32..39 run function rx.playerdb:impl/select/bit1/32_39
execute if score $bit rx.temp matches 40..47 run function rx.playerdb:impl/select/bit1/40_47
execute if score $bit rx.temp matches 48..55 run function rx.playerdb:impl/select/bit1/48_55
execute if score $bit rx.temp matches 56..63 run function rx.playerdb:impl/select/bit1/56_63