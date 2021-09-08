<!-- Implement's select logic -->

## select/gate

<details>

```mcfunction
# @function select/gate

#> Select Data: Output selected:1b

# set input
scoreboard players operation $uid rx.temp = $in.uid rx.io

# select
function select/main
```

</ details>

## select/main

<details>

```mcfunction
# @function select/main

#> Select Data: Output selected:1b

# verification
function verify/main

# selection
execute if score $verified rx.temp matches 0 run sequentially
	execute unless data storage rx:global playerdb.players[] run tellraw @a[tag=rx.admin] {"text":"Selection failed. No players in database to select", "color": "#CE4257"}
	execute if data storage rx:global playerdb.players[] run sequentially
		data modify storage rx:global playerdb.players[].selected set value 1b
		function select/tree/bit0
```

</ details>
