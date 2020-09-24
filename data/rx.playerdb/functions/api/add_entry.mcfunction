# By: rx97
# 10 Aug 2020
# 
#> Add entry. Call w/ @s being the player

# only run if @s doesn't have an entry
execute unless score @s rx.pdb.HasEntry = @s rx.pdb.HasEntry run function rx.playerdb:impl/add_entry
