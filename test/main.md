<!-- Testing functions -->

```python
# @plugin

from beet import Function

with open('test/player_names.txt') as f:
	names = f.read().split('\n')

cmd = 'execute if score $iter rx.temp matches {num}.. run player {name} spawn'
contents = [cmd.format(num=i, name=name) for i, name in enumerate(names)]

ctx.data['rx.playerdb:test/utils/summon/names'] = Function(contents)

for count in [10, 25, 50, 100]:
	ctx.data[f'rx.playerdb:test/utils/summon/{count}'] = Function([
		f'scoreboard players set $iter rx.temp {count}',
		'function rx.playerdb:test/utils/summon/names'
	])
```

```mcfunction
# @function rx.playerdb:test/utils/reset_self
#> Note this increments the uid counter w/o resetting it ;)
scoreboard players reset @s rx.uid
scoreboard players reset @s rx.playerdb.has_entry
function ./utils/new_uid
function #rx.playerdb:api/v2/add_entry
```

```mcfunction
# @function rx.playerdb:test/utils/create/main

function rx.playerdb:test/utils/reset_self

scoreboard players remove $loop rx.temp 1
execute if score $loop rx.temp matches 1.. run function rx.playerdb:test/utils/create/main
```

```mcfunction
# @function rx.playerdb:test/utils/modify_self

function #rx.playerdb:api/v2/get/self
execute store result storage rx.playerdb:io player.data.test int -1 run data get storage rx.playerdb:io player.data.test 
function #rx.playerdb:api/v2/save/self
```
