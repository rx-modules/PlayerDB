# By: rx97
# 29 Oct 20
# 
#> @s: player
#> iterate through all of the UUID entries

#> test
data modify storage rx:temp playerdb.UUIDTest set from storage rx:global playerdb.uuid[{selected:1b}].entries[-1].UUID
execute store success score $check rx.temp run data modify storage rx:temp playerdb.UUIDTest set from storage rx:temp playerdb.UUID

#> if $check == 1, entries DO NOT match
#> else if $check == 0, entries DO match
#> we just stop iterating if $check == 0, `[-1]` is the entry we care about!

#> iterate through entries unless we matched.
execute unless score $check rx.temp matches 0 run data modify storage rx:global playerdb.uuid[{selected:1b}].entries insert 0 from storage rx:global playerdb.uuid[{selected:1b}].entries[-1]
execute unless score $check rx.temp matches 0 run data remove storage rx:global playerdb.uuid[{selected:1b}].entries[-1]

#> found!
execute if score $check rx.temp matches 0 run scoreboard players set $found rx.temp 1

#> recurse
scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. unless score $check rx.temp matches 0 run function rx.playerdb:impl/uuid/iter
