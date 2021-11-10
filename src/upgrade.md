<!-- Upgrading :D -->

These will help migrate v1.1+ worlds to v2.0!

```mcfunction
# @function upgrade

execute store result score $patch rx.temp run
    data get storage rx:info playerdb.version.patch
execute store result score $minor rx.temp run
    data get storage rx:info playerdb.version.minor
execute store result score $major rx.temp run
    data get storage rx:info playerdb.version.major

execute if score $major rx.temp matches 1 run commands v1tov2
    data modify storage rx.playerdb:main players set from storage rx:global playerdb.players
    data modify storage rx.playerdb:main uuid set from storage rx:global playerdb.uuid

    tellraw @a from rx.playerdb:upgrade/v1tov2
```

```yaml
// @advancement upgrade/v1tov2
---

criteria:
  requirement:
    trigger: 'minecraft:tick'
```

```mcfunction
# @function upgrade/player

execute unless entity @s[advancements={ {{ ctx.generate.path('upgrade/v1tov2') ~ '=true'}} }] run function ./v1tov2/player
```

```mcfunction
# @function upgrade/v1tov2/player
#> Quickly migrate has entry
execute if score @s rx.uuid0 = @s rx.uuid0 run sequentially
    execute if score @s rx.pdb.hasEntry matches 0.. run scoreboard players operation @s rx.playerdb.has_entry = @s rx.pdb.hasEntry
    scoreboard players operation $uid rx.temp = @s rx.uuid0
    function {{ ctx.generate.path('uuid/select') }}
    execute store result storage rx.playerdb:main uuid[{selected:1b}].entries[-1].has_entry byte 1 run scoreboard players get @s rx.playerdb.has_entry
    tellraw @a[tag=rx.admin] from rx.playerdb:upgrade/v1tov2/player
```
