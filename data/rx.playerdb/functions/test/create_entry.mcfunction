# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

# tellraw @a[tag=rx.admin] {"storage":"rx:global","nbt":"playerdb.players"}
function rx.playerdb:test/reset_self

scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. run function rx.playerdb:test/create_entry
