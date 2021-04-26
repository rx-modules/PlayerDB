# By: rx97
# 25 Apr 21
# 
#> @s: player to migrate
#> Starts migration process

#> First, let's get our entry
execute store result score $uid rx.temp run data get storage rx:temp playerdb.admin.migrate.UUID[0]
function rx.playerdb:impl/uuid/select

execute if score $found rx.temp matches 0 run tellraw @a[tag=rx.admin] [{"text": "", "color":"gray"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"text": "Migration failed. Input UUID account not found.", "color": "red"}]

#> found entry 
execute if score $found rx.temp matches 1 run function rx.playerdb:impl/admin/migrate/found_acc
