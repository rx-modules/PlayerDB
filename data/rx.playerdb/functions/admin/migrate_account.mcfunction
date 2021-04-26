# By: rx97
# 25 Apr 21
# 
#> @s: player to migrate
#> Migrates old player data to new @s account
#> - input: rx:temp playerdb.admin.migrate.UUID
#> -   set as UUID array of old account
#> - output:
#> -   @s will have old rx.uid and old data

#> WARNING: This will nuke your current data and replace it
#>            with the other accounts data. Do take backups!

#> run migration if we have data
execute unless data storage rx:temp playerdb.admin.migrate.UUID run tellraw @a[tag=rx.admin] [{"text": "", "color":"gray"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"text": "Migration failed. Input in ", "color": "red"}, {"text": "rx:temp playerdb.admin.migrate", "color": "gold"}, {"text": " is empty.", "color": "red"}]
execute if data storage rx:temp playerdb.admin.migrate.UUID run function rx.playerdb:impl/admin/migrate_account
