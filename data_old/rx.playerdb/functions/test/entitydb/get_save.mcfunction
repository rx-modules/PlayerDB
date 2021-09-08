# By: rx97
# 24 Sept 20
# 
#> loop iter

function entitydb:get
#data modify storage entitydb: data.test set value 1b
data modify storage entitydb: data.inv append from entity rx97 Inventory
data modify storage entitydb: data.inv append from entity rx97 Inventory
data modify storage entitydb: data.inv append from entity rx97 Inventory
function entitydb:save
