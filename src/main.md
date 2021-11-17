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
    - id: '#rx.playerdb:load/dependencies'
      required: false

    - '#rx.playerdb:load/enumerate'
    - '#rx.playerdb:load/resolve'
```

<details>Enumerate

Since this logic is a bit tough, lets break it down here.
We are using SemVer which defines 3 parts of our version: major, minor, patch

- major defines any breaking changes, mostly pertaining to rewrites
- minor defines any new features that your pack may be relying on
- patch defines any changes or fixes which apply to the feature set

Enumerate is called upon every instance of PlayerDB which is loaded in the world. It needs to first define the greatest version of PlayerDB by comparing the major.minor.patch version and override the version if it thinks it's greater.

First we check the current major. For the first pack, it will be empty so we will be the only version. Once we find a second instance of PlayerDB, it will ask *"Am I greater than the previous major"*.

- If we are *greater*, then our version is the greatest version.
- If we are *equal*, then our version needs to check minor.
- If we are *lesser*, then our version is not the greatest version.

We then repeat these steps for minor and patch. For the final patch check, there are 3 situations:

- We are now the greatest pack version and we update the latest `load.status` version
- We are the same pack version, in which our namespaces will collide
- We are not the greatest pack version, in which we do **nothing**.

This process will ensure that the latest and greatest PlayerDB version is the one which prevails! 

</details>

```mcfunction
# @function load/enumerate
#!tag "rx.playerdb:load/enumerate"

# adapated from lepsen_core

{% set version = ctx.meta.version %}
{% set version_parts = ['major', 'minor', 'patch'] %}

{% for part in version_parts %}
scoreboard players add {{ '#rx.playerdb.' ~ part }} load.status 0
{% endfor %}

function ./major

{% for part in version_parts %}
{% function generate_path('load/' ~ part) %}

{% set fakeplayer = '#rx.playerdb.' ~ part %}
{% set ver_int = version[loop.index-1] %}

# check if the current load.status is the same or less as us
## if so, check if we match
### if not, set version since we must be better
### if so, and we didn't set a version, than check the next part
execute if score {{ fakeplayer }} load.status matches {{ '..' ~ ver_int }}
    run sequentially
        execute unless score {{ fakeplayer }} load.status matches {{ ver_int }}
            run function ./set_version
{%- if not loop.last %}
        execute if score {{ fakeplayer }} load.status matches {{ ver_int }}
            unless score #rx.playerdb.set load.status matches 1
            run function ./ {{- loop.nextitem }}
{% endif %}
{% endfunction %}
{% endfor %}

scoreboard players reset #rx.playerdb.set load.status
```

```mcfunction
# @function load/set_version

{% set version = ctx.meta.version %}

scoreboard players set #rx.playerdb.major load.status {{ version.major }}
scoreboard players set #rx.playerdb.minor load.status {{ version.minor }}
scoreboard players set #rx.playerdb.patch load.status {{ version.patch }}

scoreboard players set #rx.playerdb.set load.status 1
```

```mcfunction
# @function load/resolve
#!tag "rx.playerdb:load/resolve"

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

scoreboard objectives add rx.pdb.io dummy
scoreboard objectives add rx.pdb.list_page dummy
scoreboard objectives add rx.pdb.has_entry dummy

scoreboard objectives add rx.pdb.list trigger
scoreboard objectives add rx.pdb.counter dummy

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
scoreboard players set $global rx.pdb.counter 0

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
tellraw @a[tag=rx.admin] from rx.playerdb:load
```

```mcfunction
# @function tick
# scoreboard players enable @a rx.pdb.list
execute as @a run commands player
    # check upgrade advancements
    execute unless score @s rx.pdb.counter = $global rx.pdb.counter
        run function ../upgrade/player

    # check if uuid0 has been set
    execute unless score @s rx.uuid0 = @s rx.uuid0
        run function ../uuid/set

    # on login, chk name change
    execute unless score @s rx.pdb.counter = $global rx.pdb.counter
        run function ../uuid/check

    # list trigger
    execute unless score @s rx.pdb.list matches 0
        run function rx.playerdb:admin/list

execute store result score @a rx.pdb.counter
    run scoreboard players add $global rx.pdb.counter 1

schedule function {{ ctx.generate.path('tick') }} 1t replace
```
