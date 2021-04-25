# By: rx97
# 29 Oct 20
# 
#> @s: player
#> add new entry to uuid db

#> if selected
execute store result score $selected rx.temp if data storage rx:global playerdb.uuid[{selected:1b}] 

#> we are pretending to add an entry to players but we move it to uuid
execute if score $selected rx.temp matches 0 run scoreboard players operation $uid rx.temp = @s rx.uuid0
execute if score $selected rx.temp matches 0 run function rx.playerdb:impl/uid_to_bits
execute if score $selected rx.temp matches 0 run data modify storage rx:global playerdb.uuid append value {selected: 1b}
execute if score $selected rx.temp matches 0 run data modify storage rx:global playerdb.uuid[-1].bits set from storage rx:temp playerdb.bits
execute if score $selected rx.temp matches 0 store result storage rx:global playerdb.uuid[-1].bits.uuid0 int 1 run scoreboard players get @s rx.uuid0

function rx.playerdb:impl/get_name

#> other info
data modify storage rx:global playerdb.uuid[{selected:1b}].entries append value {}
execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid int 1 run scoreboard players get @s rx.uid
execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry byte 1 run scoreboard players get @s rx.pdb.HasEntry
data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name set from storage rx:temp playerdb.player_name 
data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].UUID set from storage rx:temp playerdb.UUID
