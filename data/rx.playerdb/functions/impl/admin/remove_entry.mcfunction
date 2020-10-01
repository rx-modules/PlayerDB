# By: rx97
# 14 Aug 20
# 
#> Removes storage entry only.
#> input: $in.uid rx.io
#> MUST RESET @s rx.uid manually!

#> perform select as long as input is less than $uid.next
execute if score $in.uid rx.io < $uid.next rx.uid run function rx.playerdb:impl/select
execute unless score $in.uid rx.io < $uid.next rx.uid run scoreboard players set $size rx.temp 0
execute unless score $in.uid rx.io < $uid.next rx.uid run say hi

scoreboard players operation $uid rx.temp = $in.uid rx.io
scoreboard players add $uid rx.temp 1

#> if $size = 1, this means an entry was found
#>  if $in.uid + 1 != $uid.next: let's cache the uid in unused_uids (append -1 and then replace it)
execute if score $size rx.temp matches 1 unless score $uid rx.temp = $uid.next rx.uid run data modify storage rx:global playerdb.unused_uids append value -1
execute if score $size rx.temp matches 1 unless score $uid rx.temp = $uid.next rx.uid store result storage rx:global playerdb.unused_uids[-1] int 1 run scoreboard players get $in.uid rx.io

#>  else, we can decrement $uid.next
execute if score $size rx.temp matches 1 if score $uid rx.temp = $uid.next rx.uid run scoreboard players remove $uid.next rx.uid 1

#>  end: success msg and remove selected player
execute if score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Successfully removed ", "color": "gold"}, {"storage":"rx:global", "nbt": "playerdb.players[{selected:1b}].info.name", "color":"#DAD6D6"}, "'s entry"]
execute if score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Don't forget to reset their rx.pdb.HasEntry score unless you ran admin/delete_player", "color": "gold"}]
execute if score $size rx.temp matches 1 run data remove storage rx:global playerdb.players[{selected:1b}]

#> else: failed msg
execute unless score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Failed to remove entry. Entry does not exist", "color": "#CE4257"}]
