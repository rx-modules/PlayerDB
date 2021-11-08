<!-- Upgrading :D -->

These will help migrate v1.1+ worlds to v2.0!

```mcfunction
# @function upgrade

execute store result score $patch rx.temp run data get storage rx:info playerdb.version.patch
execute store result score $minor rx.temp run data get storage rx:info playerdb.version.minor
execute store result score $major rx.temp run data get storage rx:info playerdb.version.major

execute if score $major rx.temp matches 1 run commands v1tov2
	data modify storage rx.playerdb:main players set from storage rx:global playerdb.players
	data modify storage rx.playerdb:main uuid set from storage rx:global playerdb.uuid

	data modify storage rx.playerdb:main meta.upgrade.has_entry set value 1b
```
