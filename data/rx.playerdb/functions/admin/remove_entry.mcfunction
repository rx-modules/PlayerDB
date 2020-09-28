# By: rx97
# 14 Aug 20
# 
#> Removes storage entry only.
#> input: $in.uid rx.io
#> MUST RESET @s rx.pdb.HasEntry manually!

execute if score $in.uid rx.io < $uid.next rx.uid run function rx.playerdb:impl/admin/remove_entry
execute unless score $in.uid rx.io < $uid.next rx.uid run tellraw @a[tag=rx.admin] [{"text": "Failed to remove entry. Entry does not exist (outside max range)", "color": "#CE4257"}]
