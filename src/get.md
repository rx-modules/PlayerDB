<!-- Implement's get logic -->

## get/gate

<details>

```mcfunction
# @function get/gate

#> Get Data: Output in rx:io out.player
#> TODO: make tellraws referenced from a file

execute if score $in.uid rx.io < $uid.next rx.uid run sequentially
	function select/gate
	function get/main

execute if score $in.uid rx.io >= $uid.next rx.uid run sequentially
	data remove storage rx:io playerdb.player
	tellraw @a[tag=rx.admin] {"text":"Unsuccessful get. Input uid above max uid", "color": "#CE4257"}
```

</details>

## get/main

<details>

```mcfunction
# @function get/main

#> Get Data: Output in rx:io out.player

# size leftover from select
execute if score $size rx.temp matches 1 run sequentially
	data modify storage rx:io playerdb.player set from storage rx:global playerdb.players[{selected:1b}]
	data remove storage rx:io playerdb.player.bits

execute if score $size rx.temp matches ..0 run data modify storage rx:io playerdb.player set value {}

# sanity check, output -> playerdb.player
execute store result score $uid rx.temp run data get storage rx:io playerdb.player.info.uid
execute unless score $uid rx.temp = $in.uid rx.io run data modify storage rx:io playerdb.player set value {}
```

</details>

## save/self

<details>

```mcfunction
# @function get/self

#> Get @s Data: Output in rx:io out.player

#> api add_entry, won't add unless we need to. $entry: 1: we have entry, 0: we don't have entry
function add_entry/main

scoreboard players operation $in.uid rx.io = @s rx.uid
function get/gate
```

</details>
