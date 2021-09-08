<!-- Admin Commands -->

```mcfunction
# @function rx.playerdb:admin/delete_player

#> Removes player entry
#> input:
#> * player to delete: @s

execute unless score @s rx.uid < $uid.next rx.uid run tellraw @a[tag=rx.admin] [{"text": "Failed to delete player. Player entry does not exist (outside max range)", "color": "#CE4257"}]
execute if score @s rx.uid < $uid.next rx.uid run function rx.playerdb:impl/admin/delete_player
```

```mcfunction
# @function rx.playerdb:admin/migrate_account

#> @s: player to migrate
#> Migrates old player data to new @s account
#> - input: rx:temp playerdb.admin.migrate.UUID
#> -   set as UUID array of old account
#> - output:
#> -   @s will have old rx.uid and old data

#> WARNING: This will nuke your current data and replace it
#>            with the other accounts data. Do take backups!

#> run migration if we have data
execute unless data storage rx:temp playerdb.admin.migrate.UUID run tellraw @a[tag=rx.admin] [{"text": "", "color":"gray"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"text": "Migration failed. Input in ", "color": "#CE4257"}, {"text": "rx:temp playerdb.admin.migrate", "color": "gold"}, {"text": " is empty.", "color": "#CE4257"}]
execute if data storage rx:temp playerdb.admin.migrate.UUID run function rx.playerdb:impl/admin/migrate_account
```

```mcfunction
# @function rx.playerdb:admin/reset_all

#> Resets Storage. WARNING: CANNOT UNDO THIS OPERATION

#define storage rx:global
#define storage rx:temp
#define storage rx:io

scoreboard players reset * rx.uid
scoreboard players reset * rx.uuid0
scoreboard players reset * rx.uuid1
scoreboard players reset * rx.uuid2
scoreboard players reset * rx.uuid3
scoreboard players reset * rx.pdb.HasEntry
scoreboard players set $uid.next rx.uid 1

data modify storage rx:global playerdb set value {}
data modify storage rx:temp playerdb set value {}
data modify storage rx:io playerdb set value {}

data modify storage rx:global playerdb.players set value []
data modify storage rx:global playerdb.uuid set value []

scoreboard players set @a rx.pdb.login 1
```

```mcfunction
# @function rx.playerdb:admin/reset_all

#> Resets Storage. WARNING: CANNOT UNDO THIS OPERATION

#define storage rx:global
#define storage rx:temp
#define storage rx:io

scoreboard players reset * rx.uid
scoreboard players reset * rx.uuid0
scoreboard players reset * rx.uuid1
scoreboard players reset * rx.uuid2
scoreboard players reset * rx.uuid3
scoreboard players reset * rx.pdb.HasEntry
scoreboard players set $uid.next rx.uid 1

data modify storage rx:global playerdb set value {}
data modify storage rx:temp playerdb set value {}
data modify storage rx:io playerdb set value {}

data modify storage rx:global playerdb.players set value []
data modify storage rx:global playerdb.uuid set value []

scoreboard players set @a rx.pdb.login 1
```
