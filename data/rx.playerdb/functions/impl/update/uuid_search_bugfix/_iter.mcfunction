# By: GrifterMage
# 19 Apr 2021
# 
#> iterate

#> Select appropriate entry, if any
data modify storage rx:temp playerdb.UUID set from storage rx:temp playerdb.uuid_db_update[-1].UUID
function rx.playerdb:impl/uuid/select

#> If no element selected, create a new one
execute store result score $selected rx.temp if data storage rx:global playerdb.uuid[{selected:1b}] 
execute if score $selected rx.temp matches 0 run data modify storage rx:global playerdb.uuid append value {selected: 1b}
execute if score $selected rx.temp matches 0 store result score $uid rx.temp run data get storage rx:temp playerdb.uuid_db_update[-1].UUID[0]
execute if score $selected rx.temp matches 0 run data remove storage rx:temp playerdb.bits
execute if score $selected rx.temp matches 0 run function rx.playerdb:impl/uid_to_bits
execute if score $selected rx.temp matches 0 run data modify storage rx:global playerdb.uuid[-1].bits set from storage rx:temp playerdb.bits

#> Store the current record into the selected position
data modify storage rx:global playerdb.uuid[{selected:1b}].entries append from storage rx:temp playerdb.uuid_db_update[-1]
data remove storage rx:temp playerdb.uuid_db_update[-1]

# iterate
execute unless data storage rx:temp playerdb.uuid_db_update[] run data remove storage rx:temp playerdb.uuid_db_update
execute if data storage rx:temp playerdb.uuid_db_update[] run function rx.playerdb:impl/update/uuid_search_bugfix/_iter
