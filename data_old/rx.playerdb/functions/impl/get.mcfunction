# By: rx97
# 26 Sept 20
# 
#> Get Data: Output in rx:io out.player

#define entity @s

# size leftover from select
execute if score $size rx.temp matches 1 run data modify storage rx:io playerdb.player set from storage rx:global playerdb.players[{selected:1b}]
execute if score $size rx.temp matches 1 run data remove storage rx:io playerdb.player.bits
execute if score $size rx.temp matches ..0 run data modify storage rx:io playerdb.player set value {}

# sanity check, output -> playerdb.player
execute store result score $uid rx.temp run data get storage rx:io playerdb.player.info.uid
execute unless score $uid rx.temp = $in.uid rx.io run data modify storage rx:io playerdb.player set value {}
