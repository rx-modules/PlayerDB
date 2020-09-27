# By: rx97
# 14 Aug 20
# 
#> Removes storage entry only.
#> input: $in.uid rx.io
#> MUST RESET @s rx.uid manually!

# perform select
execute if score $in.uid rx.io < $uid.next rx.uid run function rx.playerdb:impl/select
execute unless score $in.uid rx.io < $uid.next rx.uid run scoreboard players set $size rx.temp 0

#> if $size = 1, this means an entry was found
execute if score $size rx.temp matches 1 store result storage rx:temp playerdb.uid int 1 run scoreboard players get $in.uid rx.io
execute if score $size rx.temp matches 1 run data modify storage rx:global playerdb.unused_uids append from storage rx:temp playerdb.uid

execute if score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Successfully removed ", "color": "gold"}, {"storage":"rx:global", "nbt": "playerdb.players[{selected:1b}].info.name", "color":"#DAD6D6"}, "'s entry"]
execute if score $size rx.temp matches 1 run data remove storage rx:global playerdb.players[{selected:1b}]

#> else:
execute unless score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Failed to remove entry. Entry does not exist", "color": "#CE4257"}]
