# By: rx97
# 02 Nov 20
# 
#> @s: player
#> Player tick

# check if uuid0 has been set
execute unless score @s rx.uuid0 = @s rx.uuid0 run function rx.playerdb:impl/uuid/set

# on login, chk name change
execute if score @s rx.login matches 1.. run function rx.playerdb:impl/uuid/check

# list bs
execute unless score @s rx.List matches 0 run function rx.playerdb:admin/list
