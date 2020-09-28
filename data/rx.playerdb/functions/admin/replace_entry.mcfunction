# By: rx97
# 21 Sept 21 
# 
#> Replaces entry with @s
#> input:
#> * entry to replace : $in.uid rx.io
#> * entry replacing ^: @s rx.uid
#> MUST RESET @s rx.uid manually!

scoreboard players set $failed rx.temp 1
execute if score @s rx.uid < $uid.next rx.uid if score $in.uid rx.io < $uid.next rx.uid run scoreboard players set $failed rx.temp 0
execute if score $failed rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Failed to replace entry. Entry does not exist (outside max range)", "color": "#CE4257"}]
execute if score $failed rx.temp matches 0 run function rx.playerdb:impl/admin/replace_entry
