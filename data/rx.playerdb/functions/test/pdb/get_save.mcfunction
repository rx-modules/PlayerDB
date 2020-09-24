# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

scoreboard players set $min random 1
scoreboard players set $max random 200
function rx.playerdb:api/get
data modify storage rx:io playerdb.player.data.test set value 1b
function rx.playerdb:api/save
