<!-- Utils -->

## get_name

```mcfunction
# @function utils/get_name

#> @s: player
#> Gets player name to rx.playerdb:temp name

#> get player head
execute in minecraft:overworld run sequentially
	loot replace block -30000000 0 1602 container.0 loot rx:player_head
	data modify storage rx.playerdb:temp player_name
		set from block -30000000 0 1602 Items[0].tag.SkullOwner.Name
```

## uid\_to\_bits

```mcfunction
# @function utils/uid_to_bits

{%- for i in range(6) -%}
scoreboard players operation $bit rx.temp = $uid rx.temp
execute store result storage rx.playerdb:temp bits.{{ 'b' ~ i }} byte 1
    run scoreboard players operation $bit rx.temp %= $64 rx.int

{% if not loop.last -%}
scoreboard players operation $uid rx.temp /= $64 rx.int
{% endif -%}
{%- endfor -%}

```

## new_uid

```mcfunction
# @function utils/new_uid
#> New UID

scoreboard players operation @s rx.uid = $uid.next rx.uid
scoreboard players add $uid.next rx.uid 1
```
