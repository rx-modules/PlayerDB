<!-- Utils -->

## get_name

```mcfunction
# @function utils/get_name

#> @s: player
#> Gets player name to rx:temp playerdb.name

#> get player head
execute in minecraft:overworld run sequentially
	loot replace block -30000000 0 1602 container.0 loot rx:player_head
	data modify storage rx:temp playerdb.player_name
		set from block -30000000 0 1602 Items[0].tag.SkullOwner.Name
```

## uid\_to\_bits

```python
# @plugin

from beet import Function
import math

BASE = 64
MAX_INT = 2 ** 31 - 1
DEBUG = False


COMMENT = (
    "# By: rx97\n"
)

lines = (
    f"scoreboard players operation $uid rx.temp /= ${BASE} rx.int",
    "scoreboard players operation $bit rx.temp = $uid rx.temp",
    "execute store result storage rx:temp playerdb.bits.b{bit} byte 1 run scoreboard players operation $bit rx.temp %= ${base} rx.int"
)

debug_line = 'tellraw @s[tag=rx.PDBDebug] [{"text":"", "color":"gold"}, {"text":"bit^: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]'

out = [COMMENT]
for i in range(0, int(math.log(MAX_INT, BASE)) + 2):
    if i != 0:
        out.append(lines[0])
    out.append(lines[1])
    out.append(lines[2].format(bit=i, base=BASE))
    if DEBUG:
        out.append(debug_line.replace("^", str(i)))
    out.append("\n")

ctx.generate('utils/uid_to_bits', Function('\n'.join(out)))
```

## new_uid

```mcfunction
# @function utils/new_uid
#> New UID

scoreboard players operation @s rx.uid = $uid.next rx.uid
scoreboard players add $uid.next rx.uid 1
```
