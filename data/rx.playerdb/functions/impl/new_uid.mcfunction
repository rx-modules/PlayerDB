# By: rx97
# 10 Aug 2020
# 
#> New UID

# Check for unused uids: store it on $uid
execute unless data storage rx:global playerdb.unused_uids[] run scoreboard players operation $uid rx.temp = $uid.next rx.uid
execute if data storage rx:global playerdb.unused_uids[] store result score $uid rx.temp run data get storage rx:global playerdb.unused_uids[-1]
execute if data storage rx:global playerdb.unused_uids[] run data remove storage rx:global playerdb.unused_uids[-1]

# store the uid whether it was unused or not
scoreboard players operation @s rx.uid = $uid rx.temp

# add one to next uid UNLESS we used an unused one
execute if score $uid rx.temp = $uid.next rx.uid run scoreboard players add $uid.next rx.uid 1
