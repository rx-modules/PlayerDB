# By: rx97
# 02 Nov 20
# 
#> @s: arbituary
#> Select an entry in the UUID db
#> input -> $uid, output -> $found

#> select UUID
execute if data storage rx:global playerdb.uuid[] run data modify storage rx:global playerdb.uuid[].selected set value 1b
execute if data storage rx:global playerdb.uuid[] run function rx.playerdb:impl/uuid/select/bit0

#> selected or not
execute unless data storage rx:global playerdb.uuid[{selected:1b}] run scoreboard players set $found rx.temp 0
execute if data storage rx:global playerdb.uuid[{selected:1b}] store result score $loop rx.temp if data storage rx:global playerdb.uuid[{selected:1b}].entries[]
execute if data storage rx:global playerdb.uuid[{selected:1b}] run function rx.playerdb:impl/uuid/iter
