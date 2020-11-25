# By: rx97
# 02 Nov 20
# 
#> @s: arbituary
#> Select an entry in the UUID db
#> input -> $uid, output -> $found

scoreboard players set $found rx.temp 0

#> select UUID
execute store result score $uid rx.temp run data get storage rx:temp playerdb.UUID[0]
execute if data storage rx:global playerdb.uuid[] run data modify storage rx:global playerdb.uuid[].selected set value 1b
tellraw @a[tag=rx.admin] ["", {"color": "gold", "text": "playerdb.uuid: "}, {"storage": "rx:global", "nbt": "playerdb.uuid"}]
execute if data storage rx:global playerdb.uuid[] run function rx.playerdb:impl/uuid/select/bit0
say hi
tellraw @a[tag=rx.admin] ["", {"color": "gold", "text": "playerdb.uuid: "}, {"storage": "rx:global", "nbt": "playerdb.uuid"}]
say hi2
#> selected or not
execute if data storage rx:global playerdb.uuid[{selected:1b}] store result score $loop rx.temp if data storage rx:global playerdb.uuid[{selected:1b}].entries[]
execute if data storage rx:global playerdb.uuid[{selected:1b}] run function rx.playerdb:impl/uuid/iter

tellraw @a[tag=rx.admin] ["", {"color": "gold", "text": "playerdb.uuid: "}, {"storage": "rx:global", "nbt": "playerdb.uuid"}]
