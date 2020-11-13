# By: rx97
# 11 Nov 20
# 
#> This process allows me to upgrade the datapack by checking the last version leftover

#> we chk if the int was set bc older packs won't have this system in yet

execute unless data storage rx:info playerdb.version if score $256 rx.int matches 256 run function rx.playerdb:impl/update/v07tov08
data remove storage rx:info playerdb.version
