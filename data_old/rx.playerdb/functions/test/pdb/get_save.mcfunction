# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

# scoreboard players set $min random 1
# scoreboard players set $max random 200
function rx.playerdb:api/get_self
data modify storage rx:io playerdb.player.data.test set value 1b
# data modify storage rx:io playerdb.player.data.inv append from entity rx97 Inventory
# data modify storage rx:io playerdb.player.data.inv append from entity rx97 Inventory
# data modify storage rx:io playerdb.player.data.inv append from entity rx97 Inventory
function rx.playerdb:api/save_self
