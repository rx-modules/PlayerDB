# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

scoreboard players reset @s rx.uid
scoreboard players reset @s rx.pdb.HasEntry
function rx.playerdb:impl/new_uid
function rx.playerdb:impl/add_entry
