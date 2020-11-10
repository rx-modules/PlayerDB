# By: rx97
execute if score $bit rx.temp matches 0..3 run function rx.playerdb:impl/select/bit0/0_3
execute if score $bit rx.temp matches 4..7 run function rx.playerdb:impl/select/bit0/4_7
execute if score $bit rx.temp matches 8..11 run function rx.playerdb:impl/select/bit0/8_11
execute if score $bit rx.temp matches 12..15 run function rx.playerdb:impl/select/bit0/12_15