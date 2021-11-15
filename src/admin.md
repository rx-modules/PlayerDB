<!-- Admin Commands -->

## Deleting and Removing Entries

<details>

```mcfunction
# @function rx.playerdb:admin/delete_player

#> Removes player entry
#> input:
#> * player to delete: @s

execute unless score @s rx.uid < $uid.next rx.uid
	run tellraw @a[tag=rx.admin] from rx.playerdb:admin/impossible_uid
execute if score @s rx.uid < $uid.next rx.uid run commands logic
	scoreboard players operation $in.uid rx.pdb.io = @s rx.uid
	function rx.playerdb:admin/remove_entry/logic
	execute if score $size rx.temp matches 1
		run scoreboard players reset @s rx.playerdb.has_entry
```

```mcfunction
# @function rx.playerdb:admin/remove_entry

#> Removes storage entry only.
#> input: $in.uid rx.pdb.io
#> MUST RESET @s rx.playerdb.has_entry manually!

#!set major = ctx.meta.version.major

execute unless score $in.uid rx.pdb.io < $uid.next rx.uid
	run tellraw @a[tag=rx.admin] from rx.playerdb:admin/impossible_uid
execute if score $in.uid rx.pdb.io < $uid.next rx.uid run commands logic
	#> Removes storage entry only.
	#> input: $in.uid rx.pdb.io
	#> MUST RESET @s rx.playerdb.has_entry manually!

	#> perform select as long as input is less than $uid.next
	execute if score $in.uid rx.pdb.io < $uid.next rx.uid
		run function #rx.playerdb:api/v{{major ~ '/select'}}
	execute unless score $in.uid rx.pdb.io < $uid.next rx.uid
		run scoreboard players set $size rx.temp 0

	#> if $size = 1, this means an entry was found
	execute if score $size rx.temp matches 1 run sequentially
		data modify storage rx.playerdb:temp UUID set from storage rx.playerdb:main players[{selected:1b}].info.UUID
		function uuid/select
		data modify storage rx.playerdb:main uuid[{selected:1b}].entries[-1].hasEntry set value 0b

	#>  success msg and remove selected player
	execute if score $size rx.temp matches 1 run sequentially
		tellraw @a[tag=rx.admin] from rx.playerdb:admin/successful_removal
		data remove storage rx.playerdb:main players[{selected:1b}]

	#> else: failed msg
	execute unless score $size rx.temp matches 1
		run tellraw @a[tag=rx.admin] from rx.playerdb:admin/non_existent_entry
```

</details>

## Migrate Account

<details>

```mcfunction
# @function rx.playerdb:admin/migrate_account

#> @s: player to migrate
#> Migrates old player data to new @s account
#> - input: rx.playerdb:temp admin.migrate.UUID
#> -   set as UUID array of old account
#> - output:
#> -   @s will have old rx.uid and old data

#> WARNING: This will nuke your current data and replace it
#>            with the other accounts data. Do take backups!

#> run migration if we have data
execute unless data storage rx.playerdb:temp admin.migrate.UUID
	run tellraw @a[tag=rx.admin] from rx.playerdb:admin/migration/bad_input
execute if data storage rx.playerdb:temp admin.migrate.UUID
	run function rx.playerdb:admin/migrate_account/logic
```

```mcfunction
# @function rx.playerdb:admin/migrate_account/logic

#> @s: player to migrate
#> Starts migration process

#!set major = ctx.meta.version.major

#> First, let's get our entry
execute store result score $uid rx.temp run data get storage rx.playerdb:temp admin.migrate.UUID[0]
function {{ ctx.generate.path('uuid/select') }}

execute if score $found rx.temp matches 0
	run tellraw @a[tag=rx.admin] from rx.playerdb:admin/migration/acc_not_found

#> found entry 
execute if score $found rx.temp matches 1 run commands found_acc
	#> Once we've found the acc, migrate!

	#> grab our uid and other data then nuke
	execute store result score $migrate.uid rx.temp run data get storage rx.playerdb:main uuid[{selected:1b}].entries[-1].uid
	execute store result score $migrate.hasEntry rx.temp run data get storage rx.playerdb:main uuid[{selected:1b}].entries[-1].hasEntry
	data modify storage rx.playerdb:temp admin.migrate.old_name set from storage rx.playerdb:main uuid[{selected:1b}].entries[-1].name
	data remove storage rx.playerdb:main uuid[{selected:1b}].entries[-1]

	#> nuke our current entry if it exists
	execute if score @s rx.playerdb.has_entry matches 1.. run sequentially
		scoreboard players operation $in.uid rx.pdb.io = @s rx.uid
		function #rx.playerdb:api/v2/select
		data remove storage rx.playerdb:main players[{selected:1b}]

	#> restore our old uid and data
	scoreboard players operation @s rx.uid = $migrate.uid rx.temp
	scoreboard players operation @s rx.playerdb.has_entry = $migrate.hasEntry rx.temp

	# also update name while we are at it
	execute if score @s rx.playerdb.has_entry matches 1.. run sequentially
		function #rx.playerdb:api/v{{major ~ '/get/self'}}
		function {{ ctx.generate.path('utils/get_name') }}
		data modify storage rx.playerdb:main players[{selected:1b}].info.UUID set from entity @s UUID
		data modify storage rx.playerdb:main players[{selected:1b}].info.name set from storage rx.playerdb:temp player_name
		function {{ ctx.generate.path('uuid/select') }}

	#> update our current UUID entry w/ the original uid
	scoreboard players operation $uid rx.temp = @s rx.uuid0
	function #rx.playerdb:api/v{{major ~ '/uuid'}}
	execute store result storage rx.playerdb:main uuid[{selected:1b}].entries[-1].uid byte 1 run scoreboard players get @s rx.uid
	execute store result storage rx.playerdb:main uuid[{selected:1b}].entries[-1].hasEntry byte 1 run scoreboard players get @s rx.playerdb.has_entry

	#> tellraw a success msg :D
	tellraw @a[tag=rx.admin] from rx.playerdb:admin/migration/success
	tellraw @s from rx.playerdb:admin/migration/success_to_migrated

	#> call name change api
	function #rx.playerdb:api/v{{major ~ '/on_name_change'}}

	#> cleanup
	data remove storage rx.playerdb:temp admin.migrate
```

</details>

```mcfunction
# @function rx.playerdb:admin/reset_all

#> Resets Storage. WARNING: CANNOT UNDO THIS OPERATION

scoreboard players reset * rx.uid
scoreboard players reset * rx.uuid0
scoreboard players reset * rx.uuid1
scoreboard players reset * rx.uuid2
scoreboard players reset * rx.uuid3
scoreboard players reset * rx.temp
scoreboard players reset * rx.pdb.io
scoreboard players reset * rx.playerdb.has_entry
scoreboard players set $uid.next rx.uid 1

data modify storage rx.playerdb:main players set value []
data modify storage rx.playerdb:main uuid set value []

data remove storage rx.playerdb:io player
data remove storage rx.playerdb:io player_name

scoreboard players set @a rx.playerdb.counter 0

tellraw @a[tag=rx.admin] from rx.playerdb:admin/reset
```
