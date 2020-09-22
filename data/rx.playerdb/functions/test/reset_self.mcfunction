# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

scoreboard players reset @s rx.HasEntry
scoreboard players reset @s rx.uid
function rx.playerdb:impl/new_uid
function rx.playerdb:api/add_entry
