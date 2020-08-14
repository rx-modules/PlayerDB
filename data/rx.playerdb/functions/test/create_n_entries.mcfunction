# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

function rx.playerdb:admin/reset_self

scoreboard players remove $entries rx.temp 1
execute if score $entries rx.temp matches 1.. run function rx.playerdb:test/create_n_entries
