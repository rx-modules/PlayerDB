# By: GrifterMage
# 19 Apr 2021
#> Separate merged UUID database caused by bug in UUID Select

# extract entries for input
data modify storage rx:temp playerdb.uuid_db_update set value []
execute if data storage rx:global playerdb.uuid[] run data modify storage rx:temp playerdb.uuid_db_update append from storage rx:global playerdb.uuid[].entries[]

# purge existing database
execute if data storage rx:global playerdb.uuid[] run data remove storage rx:global playerdb.uuid[]

# iterate
execute if data storage rx:temp playerdb.uuid_db_update[] run function rx.playerdb:impl/update/uuid_search_bugfix/_iter
tellraw @a[tag=rx.admin] [{"text":"", "color":"gray"}, {"nbt": "playerdb.pretty_name", "storage": "rx:info", "interpret": true}, ": UUID database reconstructed"]
