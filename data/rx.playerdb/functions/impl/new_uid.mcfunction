# By: rx97
# 10 Aug 2020
# 
#> New UID

scoreboard players operation @s rx.uid = $uid.next rx.uid
scoreboard players add $uid.next rx.uid 1
