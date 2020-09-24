# By: rx97
# 14 Aug 20
# 
#> Get Data: Output in rx:io out.player

#define entity @s

# set input / reset temp
scoreboard players operation $uid rx.temp = $in.uid rx.io
data modify storage rx:temp playerdb set value {}

# split into leftovers <> player
data modify storage rx:temp playerdb.filtered0 set from storage rx:global playerdb.players
function rx.playerdb:impl/split/bit0
