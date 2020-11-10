# By: rx97
# 14 Aug 20
# 
#> Removes storage entry only.
#> input: $in.uid rx.io
#> MUST RESET @s rx.pdb.HasEntry manually!

#> perform select as long as input is less than $uid.next
execute if score $in.uid rx.io < $uid.next rx.uid run function rx.playerdb:api/select
execute unless score $in.uid rx.io < $uid.next rx.uid run scoreboard players set $size rx.temp 0

#> if $size = 1, this means an entry was found
execute if score $size rx.temp matches 1 run data modify storage rx:temp playerdb.UUID set from storage rx:global playerdb.players[{selected:1b}].info.UUID
execute if score $size rx.temp matches 1 run function rx.playerdb:impl/uuid/select
execute if score $size rx.temp matches 1 run data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry set value 0b

#>  success msg and remove selected player
execute if score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Successfully removed ", "color": "gold"}, {"storage":"rx:global", "nbt": "playerdb.players[{selected:1b}].info.name", "color":"#DAD6D6"}, "'s entry"]
execute if score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Don't forget to reset their rx.pdb.HasEntry score unless you ran admin/delete_player", "color": "gold"}]
execute if score $size rx.temp matches 1 run data remove storage rx:global playerdb.players[{selected:1b}]

#> else: failed msg
execute unless score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Failed to remove entry. Entry does not exist", "color": "#CE4257"}]
