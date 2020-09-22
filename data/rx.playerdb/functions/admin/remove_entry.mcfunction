# By: rx97
# 14 Aug 20
# 
#> Removes storage entry only.
#> input: $in.uid rx.io
#> MUST RESET @s rx.uid manually!

execute if score $in.uid rx.io < $uid.next rx.uid store result storage rx:temp playerdb.uid int 1 run scoreboard players get $in.uid rx.io
execute if score $in.uid rx.io < $uid.next rx.uid run data modify storage rx:global playerdb.unused_uids append from storage rx:temp playerdb.uid

# perform split
function rx.playerdb:impl/split

# replace globals w/ leftovers
execute if data storage rx:io playerdb.player run data modify storage rx:global playerdb.players set from storage rx:temp playerdb.leftover

# reset temp
data modify storage rx:temp playerdb set value {}
