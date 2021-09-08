# By: rx97
# 14 Aug 20
# 
#> Lists all players

execute unless score @s rx.pdb.LT matches 0 run scoreboard players operation @s rx.pdb.list += @s rx.pdb.LT
execute unless score @s rx.pdb.list = @s rx.pdb.list run scoreboard players set @s rx.pdb.list 1
function rx.playerdb:impl/admin/list
scoreboard players set @s rx.pdb.LT 0
