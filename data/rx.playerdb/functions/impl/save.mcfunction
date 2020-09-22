# By: rx97
# 14 Aug 20
# 
#> Save Data
# assumes we have split

# if there is player data, we can insert and replace global!
execute if data storage rx:io playerdb.player run data modify storage rx:temp playerdb.leftover append from storage rx:io playerdb.player
execute if data storage rx:io playerdb.player run data modify storage rx:global playerdb.players set from storage rx:temp playerdb.leftover

# reset temp
data modify storage rx:temp playerdb set value {}
