# By: rx97
# 10 Aug 2020
# 
#> Add entry. Call w/ @s being the player

#define storage rx:global

# only run if @s doesn't have an entry
execute unless entity @s[tag=rx.playerdb.HasEntry] run function rx.playerdb:impl/add_entry
