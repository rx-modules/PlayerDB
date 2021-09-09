<!-- Main entry points from LL -->

Essentially, every PlayerDB sits in it's own namespace. When the pack loads, every version of PlayerDB runs a version checker which essentially sets a score if it's a newer version than the pack before it.

```yaml
// @function_tag rx.playerdb:load
values:
- '#rx.playerdb:impl/enumerate'
- '#rx.playerdb:impl/resolve'
```

```mcfunction
# @function rx.playerdb:impl/enumerate
#!tag "rx.playerdb:impl/enumerate"

#!set major = ctx.meta.version.major
#!set minor = ctx.meta.version.minor
#!set patch = ctx.meta.version.patch

execute
    unless score #rx.pdb.major load.status matches __major__..
    run scoreboard players set #rx.pdb.major load.status __major__
execute
    if score #rx.pdb.major load.status matches __major__
    unless score #rx.pdb.minor load.status matches __minor__..
    run scoreboard players set #rx.pdb.minor load.status __minor__
execute
    if score #rx.pdb.major load.status matches __major__
    if score #rx.pdb.minor load.status matches __minor__
    unless score #rx.pdb.patch load.status matches __patch__..
    run scoreboard players set #rx.pdb.patch load.status __patch__
```

```mcfunction
# @function rx.playerdb:impl/resolve
#!tag "rx.playerdb:impl/resolve"

#!set major = ctx.meta.version.major
#!set minor = ctx.meta.version.minor
#!set patch = ctx.meta.version.patch

schedule clear rx.playerdb:impl/v{{verstr}}/tick
execute
	if score #rx.pdb.major load.status matches __major__
	if score #rx.pdb.minor load.status matches __minor__
	if score #rx.pdb.patch load.status matches __patch__
	run function rx.playerdb:impl/v{{verstr}}/init
```

```mcfunction
# @function init

#> Does actual init
#!set pname = ctx.meta.globals.pretty_name | tojson
data modify storage rx:info playerdb.name set value 'PlayerDB'
data modify storage rx:info playerdb.pretty_name set value __pname__

#> LL Load + version
scoreboard players set rx.pdb load.status 1

#!set major = ctx.meta.version.major
#!set minor = ctx.meta.version.minor
#!set patch = ctx.meta.version.patch
data modify storage rx:info playerdb.version
	set value {major: __major__, minor: __minor__, patch: __patch__}

data modify storage rx:info playerdb.pretty_version 
	set value '[{"storage": "rx:info", "nbt": "playerdb.version.major"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.minor"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.patch"}]'

scoreboard objectives add rx.io dummy
scoreboard objectives add rx.uid dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy

scoreboard objectives add rx.pdb.list dummy
scoreboard objectives add rx.pdb.HasEntry dummy

scoreboard objectives add rx.pdb.LT trigger
scoreboard objectives add rx.pdb.login minecraft.custom:minecraft.leave_game

#> 0.8+: uuid storage
scoreboard objectives add rx.uuid0 dummy
scoreboard objectives add rx.uuid1 dummy
scoreboard objectives add rx.uuid2 dummy
scoreboard objectives add rx.uuid3 dummy

#> only sets if unset ;)
execute unless score $uid.next rx.uid matches -2147483648..
	run scoreboard players set $uid.next rx.uid 1

scoreboard players set $2 rx.int 2
scoreboard players set $3 rx.int 3
scoreboard players set $16 rx.int 16
scoreboard players set $19 rx.int 19
scoreboard players set $64 rx.int 64
scoreboard players set $256 rx.int 256

#> start our tick loop
schedule function ./tick 1t replace

#> phi chunk
# I'll need this in the future, + it's better than my rx-stand
forceload remove -30000000 1600
forceload add -30000000 1600

execute unless block -30000000 0 1602 minecraft:yellow_shulker_box
	run setblock -30000000 0 1602 minecraft:yellow_shulker_box

execute unless block -30000000 0 1603 minecraft:oak_wall_sign
	run setblock -30000000 0 1603 minecraft:oak_wall_sign[facing=south]

fill -30000000 1 1600 -30000000 1 1615 minecraft:bedrock

#> cool admin msg is cool
tellraw @a[tag=rx.admin] [{"text":"", "color":"gray"}, {"nbt": "playerdb.pretty_name", "storage": "rx:info", "interpret": true}, " ", {"storage": "rx:info", "nbt": "playerdb.pretty_version", "interpret": true}, " loaded"]
```
