<!-- Implement's save logic -->

## save/gate

<details>

```mcfunction
# @function save/gate

# optimization baked in
function select/gate

# verify that rx:io is proper player
execute store result score $uid.check rx.temp run data get storage rx:io playerdb.player.info.uid

#> Execute a save if:
#> - data exists in rx:io
#> - data uid == input uid
#> Consume reguardless
execute unless data storage rx:io playerdb.player run tellraw @a[tag=rx.admin] {"text":"Save unsuccessful. No rx:io data to save.", "color": "#CE4257"}
execute if data storage rx:io playerdb.player unless score $uid.check rx.temp = $in.uid rx.io run tellraw @a[tag=rx.admin] {"text":"Save unsuccessful. rx:io data uid invalid", "color": "#CE4257"}
execute if data storage rx:io playerdb.player if score $uid.check rx.temp = $in.uid rx.io run function save/main
data remove storage rx:io playerdb.player

```

</details>

## save/main

<details>

```mcfunction
# @function save/main

#> Save after Select

data modify storage rx:global playerdb.players[{selected:1b}].data set from storage rx:io playerdb.player.data
```

</details>

## save/self

<details>

```mcfunction
# @function save/self

#> Save @s Data

scoreboard players operation $in.uid rx.io = @s rx.uid
function save/main
```

</details>
