# By: rx97
# 10 Aug 2020
# 
#> Add entry. Call w/ @s being the player

# fixes bug if player doesn't have uid yet
execute unless score @s rx.uid matches 1.. run function rx.playerdb:impl/new_uid
# only run if @s doesn't have an entry
execute unless score @s rx.pdb.HasEntry matches 1 run function rx.playerdb:impl/add_entry
