# By: rx97
# 21 Sept 20
# 
#> Removes player entry + their uid from system
#> input:
#> * player to delete: @s

execute unless score @s rx.uid < $uid.next rx.uid run tellraw @a[tag=rx.admin] [{"text": "Failed to delete player. Player entry does not exist (outside max range)", "color": "#CE4257"}]
execute if score @s rx.uid < $uid.next rx.uid run function rx.playerdb:impl/admin/delete_player
