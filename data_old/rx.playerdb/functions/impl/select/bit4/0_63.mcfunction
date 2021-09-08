# By: rx97
execute if score $bit rx.temp matches 0..7 run function rx.playerdb:impl/select/bit4/0_7
execute if score $bit rx.temp matches 8..15 run function rx.playerdb:impl/select/bit4/8_15
execute if score $bit rx.temp matches 16..23 run function rx.playerdb:impl/select/bit4/16_23
execute if score $bit rx.temp matches 24..31 run function rx.playerdb:impl/select/bit4/24_31
execute if score $bit rx.temp matches 32..39 run function rx.playerdb:impl/select/bit4/32_39
execute if score $bit rx.temp matches 40..47 run function rx.playerdb:impl/select/bit4/40_47
execute if score $bit rx.temp matches 48..55 run function rx.playerdb:impl/select/bit4/48_55
execute if score $bit rx.temp matches 56..63 run function rx.playerdb:impl/select/bit4/56_63