# By: rx97
# 21 Sept 21 
# 
#> Replaces entry with @s
#> input:
#> * entry to replace : $in.uid rx.io
#> * entry replacing ^: @s rx.uid
#> MUST RESET @s rx.uid manually!

# cache score
scoreboard players operation $admin rx.temp = $in.uid rx.io

# get current player and cache it
function rx.playerdb:api/get_self
data modify storage rx:io playerdb.current_player set from storage rx:io playerdb.player

# perform split with replacee's entry leaving leftover in temp
#> rx:io playerdb.player having a value ensures we found a player at that slot
scoreboard players operation $in.uid rx.io = $admin rx.temp
function rx.playerdb:impl/select

#> if we found an entry
# replace player with new data ;D
execute if score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Successfully replaced ", "color": "gold"}, {"storage":"rx:global", "nbt": "playerdb.players[{selected:1b}].info.name", "color":"#DAD6D6"}, " with ", {"storage":"rx:io", "nbt":"playerdb.current_player.info.name", "color":"#DAD6D6"}]
execute if score $size rx.temp matches 1 run data modify storage rx:io playerdb.current_player.info.uid set from storage rx:global playerdb.players[{selected:1b}].info.uid
execute if score $size rx.temp matches 1 run data modify storage rx:global playerdb.players[{selected:1b}].info set from storage rx:io playerdb.current_player.info
execute if score $size rx.temp matches 1 run data modify storage rx:global playerdb.players[{selected:1b}].data set from storage rx:io playerdb.current_player.data
execute if score $size rx.temp matches 1 run function rx.playerdb:impl/save

# swap @s and $in.uid
execute if score $size rx.temp matches 1 run scoreboard players operation $swap rx.temp = @s rx.uid
execute if score $size rx.temp matches 1 run scoreboard players operation @s rx.uid = $in.uid rx.io
execute if score $size rx.temp matches 1 run scoreboard players operation $in.uid rx.io = $swap rx.temp

# select current player's old entry and remove it. note, $size changes here but should be fine
execute if score $size rx.temp matches 1 run function rx.playerdb:impl/select
execute if score $size rx.temp matches 1 run data remove storage rx:global playerdb.players[{selected:1b}]

# handle unused_uids / $uid.next
execute if score $size rx.temp matches 1 run scoreboard players add $swap rx.temp 1
#>  if @s + 1 != $uid.next: let's cache the uid in unused_uids (append -1 and then replace it)
execute if score $size rx.temp matches 1 unless score $uid rx.temp = $uid.next rx.uid run data modify storage rx:global playerdb.unused_uids append value -1
execute if score $size rx.temp matches 1 unless score $uid rx.temp = $uid.next rx.uid store result storage rx:global playerdb.unused_uids[-1] int 1 run scoreboard players get $in.uid rx.io

#>  else:
execute if score $size rx.temp matches 1 if score $swap rx.temp = $uid.next rx.uid run scoreboard players remove $uid.next rx.uid 1


#> else:
execute unless data storage rx:io playerdb.player run tellraw @a[tag=rx.admin] {"text":"Player unsuccessfully replaced", "color": "#CE4257"}

# reset temp/others
data remove storage rx:io playerdb.current_player
scoreboard players reset $admin rx.temp
scoreboard players reset $swap rx.temp
