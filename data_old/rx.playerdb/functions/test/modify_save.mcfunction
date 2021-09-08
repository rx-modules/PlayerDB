# By: rx97
# 14 Aug 20
# 
#> tests get modify save

function rx.playerdb:api/get_self
data modify storage rx:io playerdb.player.data.test set value 1b
# execute as @a[limit=10] run data modify storage rx:io playerdb.player.data.players append from entity @s Inventory
function rx.playerdb:api/save_self
