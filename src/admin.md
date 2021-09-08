<!-- Admin Commands -->

## Deleting and Removing Entries

<details>

```mcfunction
# @function rx.playerdb:admin/delete_player

#> Removes player entry
#> input:
#> * player to delete: @s

execute unless score @s rx.uid < $uid.next rx.uid run tellraw @a[tag=rx.admin] [{"text": "Failed to delete player. Player entry does not exist (outside max range)", "color": "#CE4257"}]
execute if score @s rx.uid < $uid.next rx.uid run function rx.playerdb:admin/delete_player/logic
```

```mcfunction
# @function rx.playerdb:admin/delete_player/logic

#> Removes player entry + their uid from system
#> input:
#> * player to delete: @s

scoreboard players operation $in.uid rx.io = @s rx.uid
function rx.playerdb:admin/remove_entry/logic
execute if score $size rx.temp matches 1 run scoreboard players reset @s rx.pdb.HasEntry
```

```mcfunction
# @function rx.playerdb:admin/remove_entry

#> Removes storage entry only.
#> input: $in.uid rx.io
#> MUST RESET @s rx.pdb.HasEntry manually!

execute if score $in.uid rx.io < $uid.next rx.uid run function rx.playerdb:admin/remove_entry/logic
execute unless score $in.uid rx.io < $uid.next rx.uid run tellraw @a[tag=rx.admin] [{"text": "Failed to remove entry. Entry does not exist (outside max range)", "color": "#CE4257"}]
```

```mcfunction
# @function rx.playerdb:admin/remove_entry/logic

#> Removes storage entry only.
#> input: $in.uid rx.io
#> MUST RESET @s rx.pdb.HasEntry manually!

#> perform select as long as input is less than $uid.next
execute if score $in.uid rx.io < $uid.next rx.uid run function #rx.playerdb:api/select
execute unless score $in.uid rx.io < $uid.next rx.uid run scoreboard players set $size rx.temp 0

#> if $size = 1, this means an entry was found
execute if score $size rx.temp matches 1 run sequentially
	data modify storage rx:temp playerdb.UUID set from storage rx:global playerdb.players[{selected:1b}].info.UUID
	function uuid/select
	data modify storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry set value 0b

#>  success msg and remove selected player
execute if score $size rx.temp matches 1 run sequentially
	tellraw @a[tag=rx.admin] [{"text": "Successfully removed ", "color": "gold"}, {"storage":"rx:global", "nbt": "playerdb.players[{selected:1b}].info.name", "color":"#DAD6D6"}, "'s entry"]
	tellraw @a[tag=rx.admin] [{"text": "Don't forget to reset their rx.pdb.HasEntry score unless you ran admin/delete_player", "color": "gold"}]
	data remove storage rx:global playerdb.players[{selected:1b}]

#> else: failed msg
execute unless score $size rx.temp matches 1 run tellraw @a[tag=rx.admin] [{"text": "Failed to remove entry. Entry does not exist", "color": "#CE4257"}]
```

</details>

## Migrate Account

<details>


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
execute if data storage rx:temp playerdb.admin.migrate.UUID run function rx.playerdb:admin/migrate_account/logic
```

```mcfunction
# @function rx.playerdb:admin/migrate_account/logic

#> @s: player to migrate
#> Starts migration process

#> First, let's get our entry
execute store result score $uid rx.temp run data get storage rx:temp playerdb.admin.migrate.UUID[0]
function uuid/select

execute if score $found rx.temp matches 0 run tellraw @a[tag=rx.admin] [{"text": "", "color":"gray"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"text": "Migration failed. Input UUID account not found.", "color": "#CE4257"}]

#> found entry 
execute if score $found rx.temp matches 1 run commands found_acc
	#> Once we've found the acc, migrate!

	#> grab our uid and other data then nuke
	execute store result score $migrate.uid rx.temp run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid
	execute store result score $migrate.hasEntry rx.temp run data get storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry
	data modify storage rx:temp playerdb.admin.migrate.oldName set from storage rx:global playerdb.uuid[{selected:1b}].entries[-1].name
	data remove storage rx:global playerdb.uuid[{selected:1b}].entries[-1]

	#> nuke our current entry if it exists
	execute if score @s rx.pdb.HasEntry matches 1.. run sequentially
		scoreboard players operation $in.uid rx.io = @s rx.uid
		function #rx.playerdb:api/v2/select
		data remove storage rx:global playerdb.players[{selected:1b}]

	#> restore our old uid and data
	scoreboard players operation @s rx.uid = $migrate.uid rx.temp
	scoreboard players operation @s rx.pdb.HasEntry = $migrate.hasEntry rx.temp

	# also update name while we are at it
	execute if score @s rx.pdb.HasEntry matches 1.. run sequentially
		function #rx.playerdb:api/v2/get_self
		data modify storage rx:global playerdb.players[{selected:1b}].info.UUID set from entity @s UUID
		function utils/get_name
		data modify storage rx:global playerdb.players[{selected:1b}].info.name set from storage rx:temp playerdb.player_name
		function #rx.playerdb:api/v2/save_self

	#> update our current UUID entry w/ the original uid
	scoreboard players operation $uid rx.temp = @s rx.uuid0
	function rx.playerdb:impl/uuid/select
	execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].uid byte 1 run scoreboard players get @s rx.uid
	execute store result storage rx:global playerdb.uuid[{selected:1b}].entries[-1].hasEntry byte 1 run scoreboard players get @s rx.pdb.HasEntry

	#> tellraw a success msg :D
	tellraw @a[tag=rx.admin] [{"text": "", "color": "green"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"storage": "rx:temp", "nbt": "playerdb.admin.migrate.oldName", "color": "gold"}, "'s data was migrated to ", {"selector": "@s", "color": "gold"}]
	tellraw @a[tag=rx.admin] [{"text": "", "color": "gray"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": Run `/scoreboard players reset ", {"storage": "rx:temp", "nbt": "playerdb.admin.migrate.oldName", "color": "gold"}, "` to complete the migration process!"]
	tellraw @s [{"text": "", "color": "green"}, {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, ": ", {"storage": "rx:temp", "nbt": "playerdb.admin.migrate.oldName", "color": "gold"}, "'s data was successfully migrated to you!"]

	#> call name change api
	function #rx.playerdb:api/v2/on_name_change

	#> cleanup
	data remove storage rx:temp playerdb.admin.migrate
```

</details>

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
