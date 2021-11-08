<!-- Main entry points from LL -->

Essentially, every PlayerDB sits in it's own namespace. When the pack loads, every version of PlayerDB runs a version checker which essentially sets a score if it's a newer version than the pack before it.

```yaml
// @function_tag load:load
values:
- '#rx.playerdb:load'
```

```yaml
// @function_tag rx.playerdb:load
values:
- '#rx.playerdb:impl/enumerate'
- '#rx.playerdb:impl/resolve'
```

```mcfunction
# @function enumerate
#!tag "rx.playerdb:impl/enumerate"

# adapated from lepsen_core

{% set version = ctx.meta.version %}

execute
    unless score #rx.playerdb.major load.status matches {{version.major ~ '..'}}
    run scoreboard players set #rx.playerdb.major load.status {{version.major}}
execute
    if score #rx.playerdb.major load.status matches {{version.major}}
    unless score #rx.playerdb.minor load.status matches {{version.minor ~ '..'}}
    run scoreboard players set #rx.playerdb.minor load.status {{version.minor}}
execute
    if score #rx.playerdb.major load.status matches {{version.major}}
    if score #rx.playerdb.minor load.status matches {{version.minor}}
    unless score #rx.playerdb.patch load.status matches {{version.patch ~ '..'}}
    run scoreboard players set #rx.playerdb.patch load.status {{version.patch}}
```

```mcfunction
# @function resolve
#!tag "rx.playerdb:impl/resolve"

{% set version = ctx.meta.version %}

schedule clear rx.playerdb:impl/v{{verstr ~ '/tick'}}
execute
	if score #rx.playerdb.major load.status matches {{version.major}}
	if score #rx.playerdb.minor load.status matches {{version.minor}}
	if score #rx.playerdb.patch load.status matches {{version.patch}}
	run function rx.playerdb:impl/v{{verstr ~ '/init'}}
```

```mcfunction
# @function init

#> Does actual init
data modify storage rx:info playerdb.name set value 'PlayerDB'
data modify storage rx:info playerdb.pretty_name set value '{{ctx.meta.globals.pretty_name | tojson}}'

#> LL Load + version
scoreboard players set rx.playerdb load.status 1

scoreboard objectives add rx.temp dummy
function ./upgrade

{% set version = ctx.meta.version %}
data modify storage rx:info playerdb.version
	set value {major: {{version.major}}, minor: {{version.minor}}, patch: {{version.patch}}}

data modify storage rx:info playerdb.pretty_version
	set value '[{"storage": "rx:info", "nbt": "playerdb.version.major"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.minor"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.patch"}]'

scoreboard objectives add rx.uid dummy
scoreboard objectives add rx.int dummy

scoreboard objectives add rx.playerdb.io dummy
scoreboard objectives add rx.playerdb.list_page dummy
scoreboard objectives add rx.playerdb.has_entry dummy

scoreboard objectives add rx.playerdb.list trigger
scoreboard objectives add rx.playerdb.counter dummy

#> 0.8+: uuid storage
scoreboard objectives add rx.uuid0 dummy
scoreboard objectives add rx.uuid1 dummy
scoreboard objectives add rx.uuid2 dummy
scoreboard objectives add rx.uuid3 dummy

#> only sets if unset ;)
execute unless score $uid.next rx.uid matches -2147483648..
	run scoreboard players set $uid.next rx.uid 1

# global counter to keep track of logins
#  also works for server crashes ;)
scoreboard players set $global rx.playerdb.counter 1
scoreboard players operation @a rx.playerdb.counter = $global rx.playerdb.counter

scoreboard players set $2 rx.int 2
scoreboard players set $3 rx.int 3
scoreboard players set $16 rx.int 16
scoreboard players set $19 rx.int 19
scoreboard players set $64 rx.int 64
scoreboard players set $256 rx.int 256

#> start our tick loop
schedule function {{ctx.generate.path('tick')}} 1t replace

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

```mcfunction
# @function tick
# scoreboard players enable @a rx.playerdb.list
execute as @a run commands player
	# check if uuid0 has been set
	execute unless score @s rx.uuid0 = @s rx.uuid0 run function ../uuid/set

	# on login, chk name change
	execute unless score @s rx.playerdb.counter = $global rx.playerdb.counter run function ../uuid/check
	scoreboard players operation @s rx.playedb.counter = $global rx.playerdb.counter

	# list trigger
	execute unless score @s rx.playerdb.list matches 0 run function rx.playerdb:admin/list

scoreboard players add $global rx.playerdb.counter 1
scoreboard players operation @a rx.playerbd.counter = $global rx.playerdb.counter
schedule function {{ctx.generate.path('tick')}} 1t replace
```
