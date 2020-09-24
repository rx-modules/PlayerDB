# By: rx97
# 24 Sept 20
# 
#> loop iter

function entitydb:get
data modify storage entitydb: data.test set value 1b
# execute as @a[limit=10] run data modify storage entitydb: data.players append from entity @s Inventory
function entitydb:save
