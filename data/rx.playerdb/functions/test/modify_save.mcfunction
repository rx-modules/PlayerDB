# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

function rx.playerdb:api/get_self
data modify storage rx:io playerdb.player.data.test set value 1b
function rx.playerdb:api/save_self
