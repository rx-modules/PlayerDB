# By: rx97
# 24 Mar 2020
# 
#> Get Self Data

#> api add_entry, won't add unless we need to. $entry: 1: we have entry, 0: we don't have entry
function rx.playerdb:api/add_entry

scoreboard players operation $in.uid rx.io = @s rx.uid
function rx.playerdb:api/get
