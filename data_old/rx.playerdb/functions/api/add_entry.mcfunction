# By: rx97
# 10 Aug 2020
# 
#> Add entry. Call w/ @s being the player

#> Fixes bug if player doesn't have uuid0 yet
function rx.playerdb:player

#> Only run if @s doesn't have an entry
execute unless score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:impl/add_entry
