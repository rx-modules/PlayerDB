# By: rx97
# 24 Mar 2020
# 
#> Get Self Data

function rx.playerdb:api/add_entry
scoreboard players operation $in.uid rx.io = @s rx.uid
function rx.playerdb:impl/get
