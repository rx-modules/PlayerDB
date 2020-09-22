# By: rx97
# 21 Sept 20
# 
#> Removes player entry + their uid from system
#> input:
#> * player to delete: @s

scoreboard players operation $in.uid rx.io = @s rx.uid
function rx.playerdb:admin/remove_entry
