# By: rx97
# 14 Aug 20
# 
#> Resets Self uids **FOR DEV**

function rx.playerdb:test/random
scoreboard players operation $in.uid rx.io = @s random
function rx.playerdb:api/get
function rx.playerdb:api/save

scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. run function rx.playerdb:test/pdb/get_n
