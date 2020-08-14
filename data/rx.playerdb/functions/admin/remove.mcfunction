# By: rx97
# 14 Aug 20
# 
#> Removes a **storage** entry. DOES NOT REMOVE UID
#> input: $admin rx.temp

#define storage rx:global
#define storage rx:temp
#define storage rx:io

# perform split
scoreboard players operation $in.uid rx.io = $admin rx.temp
function rx.playerdb:impl/split

# replace globals w/ leftovers
execute if data storage rx:io playerdb.player run data modify storage rx:global playerdb.players set from storage rx:temp playerdb.leftover

# reset temp
# data modify storage rx:temp playerdb set value {}
