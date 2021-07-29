# By: rx97
# 11 Nov 20
# 
#> This process allows me to upgrade the datapack by checking the last version leftover

#> we chk if the int was set bc older packs won't have this system in yet
execute unless data storage rx:info playerdb.version if score $256 rx.int matches 256 run function rx.playerdb:impl/update/v07tov08

# #> if we are atleast major version 1 and minor version 0
# execute if data storage rx:info playerdb.version if score rx.pdb.major load matches 1 if score rx.pdb.minor load matches 0 run function rx.playerdb:impl/update/uuid_search_bugfix
# data remove storage rx:info playerdb.version
