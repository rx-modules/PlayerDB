# By: rx97
# Generated on: 14 Aug 20

execute if score $bit rx.temp matches 0..15 run function rx.playerdb:impl/get/bit1/0_15
execute if score $bit rx.temp matches 16..31 run function rx.playerdb:impl/get/bit1/16_31
execute if score $bit rx.temp matches 32..47 run function rx.playerdb:impl/get/bit1/32_47
execute if score $bit rx.temp matches 48..63 run function rx.playerdb:impl/get/bit1/48_63