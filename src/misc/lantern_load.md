<!-- Minecraft Loading --> 

```json
// @function_tag minecraft:load
{
    "values": [
        "#load:_private/load"
    ]
}
```

<!-- Lantern _private --> 

```json
// @function_tag load:_private/init
{
    "values": [
        "load:_private/init"
    ]
}

// @function_tag load:_private/load 
{
    "values": [
        "#load:_private/init",
        {"id": "#load:pre_load",  "required": false},
        {"id": "#load:load",      "required": false},
        {"id": "#load:post_load", "required": false}
    ]
}
```

<!-- Init File --> 

```mcfunction
# @function load:_private/init
# Reset scoreboards so packs can set values accurate for current load.
scoreboard objectives add load.status dummy
scoreboard players reset * load.status
```
