# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 0..3 run function rx.playerdb:impl/split/bit1/0_3
execute if score $bit rx.temp matches 4..7 run function rx.playerdb:impl/split/bit1/4_7
execute if score $bit rx.temp matches 8..11 run function rx.playerdb:impl/split/bit1/8_11
execute if score $bit rx.temp matches 12..15 run function rx.playerdb:impl/split/bit1/12_15