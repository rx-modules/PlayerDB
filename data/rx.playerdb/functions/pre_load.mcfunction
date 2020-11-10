# By: rx97
# 09 Nov 20
# 
#> Pre Load

#> I have to chk if there's any rx:info data here for updating purposes unfortuntely
#> I chk rx.int since i didn't do any favors last update
execute unless data storage rx:info playerdb.version if score $256 rx.int matches 256 run function rx.playerdb:impl/update/v07tov08

data remove storage rx:info playerdb.version
