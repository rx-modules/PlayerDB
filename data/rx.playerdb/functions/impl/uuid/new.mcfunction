# By: rx97
# 29 Oct 20
# 
#> @s: player
#> add new entry to uuid db

#> input
scoreboard players operation $uid rx.temp = @s rx.uuid0

#> we are pretending to add an entry to players but we move it to uuid
data modify storage rx:global playerdb.players append value {}
function rx.playerdb:impl/uid_to_bits
data modify storage rx:global playerdb.uuid append from storage rx:global playerdb.players[-1]
data remove storage rx:global playerdb.players[-1]

#> other info
data modify storage rx:global playerdb.uuid[-1].entries append value {}
execute store result storage rx:global playerdb.uuid[-1].entries[-1].uid int 1 run scoreboard players get @s rx.uid
execute store result storage rx:global playerdb.uuid[-1].entries[-1].hasEntry byte 1 run scoreboard players get @s rx.pdb.HasEntry
data modify storage rx:global playerdb.uuid[-1].entries[-1].UUID set from storage rx:temp playerdb.UUID
