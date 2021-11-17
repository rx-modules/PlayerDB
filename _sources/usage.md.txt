# Usage

The first step to using this pack is deciding how you want to use it. There are 3 general buckets that catch most folks:

- Shippable survival datapacs (PMC)
- Helper Pack to enable multiplayer for maps
- Public/private servers (esp for migrating name-changes)

For these methods, there are 2 main ways to then utilize this pack. You can either use it as a standalone zip. This is nice and easy and works easily by just dropping it in your `datapacks` folder which you can either ship with your map or use for your server. You can use all of the features from another datapack. You should make sure that PlayerDB is loaded at the very top of your other datapacks, so verify this via the `/datapack list` command. Feel free to skip the bundling section!

However, if you wish to ship your datapack for users in survival (like hosting on PMC), then you can consider this next section

## Bundling
*How to bundle PlayerDB v2.0+ with your datapack*

> While this process requires some minor changes to your datapack, it will make the use of this library seemless for your users and most likely, most won't even know it's existence.

First, head over to the [releases](https://github.com/rx-modules/PlayerDB/releases) tab, download the latest release, then unzip.

Grab all the contents, except the minecraft folder, inside the `data` folder, and plop them inside your own datapack's `data`. Nothing should collide here (if `global` collides, you can keep either `global/advancements/root`).

To properly merge the `minecraft` namespace, you'll have to pay a *bit* of attention.

For `tags/functions/load.json`, you will see the following contents:
```json
{
    "values": [
        "#load:_private/load"
    ]
}
```
This odd looking setup is known as lantern load and helps manage load order allowing PlayerDB to be ran first before other packs. You may be used to using the `#minecraft:load` and `#minecraft:tick` tags. Lantern load provides an alternative `#load:load` tag to use which allows your pack to ensure it runs after other packs.

Instead of placing your pack inside the `#minecraft:load` tag file, you can instead use the `#load:load` tag and insert your load function after my `#rx.playerdb:load`. For example:

```json
{
    "values": [
        "#rx.playerdb:load",
        "your_pack_here:load"
    ]
}
```

This will ensure that my pack will run it's load function before your pack, which is very important for PlayerDB to run properly. 

If you are using the `#minecraft:tick` tag for ticking code, you will need to migrate to a schedule loop based system. While this might seem like a large change, it actually won't alter much of how your code runs. Essentially, it'll ensure that all of PlayerDB's ticking code will run before your code.

To do this, at the top of your functiom, run `schedule function your_pack_here:tick 1t replace`. Instead of looping via the minecraft tick tag, you function will schedule it's execution the following tick. Now in your `load` function, you can "boot" your tick loop by running the same command!

After these steps, you should be ready to go! If you wish to update your PlayerDB to a new version, you only need to update the `rx` and `rx.playerdb` namespaces, unless written otherwise.

## Using the API

Before using this pack, you should be familiar with providing unique scoreboard ids to players and some moderate experience with the `storage` space (via `data modify`).

This datapack assigns a unique id to each player via the `rx.uid` scoreboard. To access the data stored on the data, you will need to reference a uid. Note, by default, the database will only have an entry for a player once requested / created (this allows for some performance boosts). 

Now, we can get started with some basic to moderate use cases 🎉!

### Storing simple data

This will get `@s`'s database entry. If it does not exist, it'll dynamically create it.

```mcfunction
function #rx.playerdb:api/v2/get/self
```

Our data is available at the `storage` location `rx.playerdb:io player.data`. We should write some data, notice how we organized our data by `cool_pack`.

```mcfunction
data modify storage rx.playerdb:io player.data.cool_pack set value {eggs: 3b}
```

Note that we stored our data in `author.cool_pack`. Namespacing our data allows us to have better compatibility with other packs!

Finally, let's save our data!

```mcfunction
function #rx.playerdb:api/v2/save/self
```

### Getting some previously stored data

```mcfunction
function #rx.playerdb:api/v2/get/self
execute store result score @s eggs run data get storage rx.playerdb:io player.data.cool_pack.eggs

# No need to save, we are just reading
```

Note, we've taken some numerical data and stored it on a scoreboard. Here, we've used it for a simple score for how many eggs our cool_pack owns but perhaps it could hold much more!

### Getting someone else's data
    
Sometimes, we don't want to get our own data, but someone else's. Let's say that we have someone else's id stored in `author.obj`.

```mcfunction
scoreboard players operation $in.uid rx.playerdb.io = @s author.obj

# Note that we are using `api/get` here, `get` will **not** make a new entry on the fly
function #rx.playerdb:api/v2/get

# Let's hope they had some eggs stored
execute store result score @s eggs run data get storage rx.playerdb:io player.data.cool_pack.eggs

# No need to save, we are just reading someone else's data ;)
# If we were to... steal some eggs, we could save that change via:
#     function #rx.playerdb:api/v2/save
```

### Other Basic Features
    
We can manually add a player entry for `@s` via:
    
```mcfunction
function #rx.playerdb:api/v2/add_entry
```

You generally will never need to create a manual entry, but the api is available just incase!

We can also 'select'/filter data for a player with id: `$in.uid rx:io`
This exposing some internal logic, essentially outputs an entry at `rx.playerdb:main players[{selected:1b}]`. This does interface with the live database, so you'll wanna be careful if you are using this.

```mcfunction
scoreboard players operation $in.uid rx.playerdb.io = @s rx.uid
function #rx.playerdb:api/v2/select

# (Note: select is much faster than a `get`/`save` which is why I've included in the api)
```

We can check whether or not a player has a database entry. This incentivizes not creating a database entry for every player, but rather creating them dynamically when you need them. You can hook into the `#api/v2/on_entry_add` function tag which is talked about in a later section.

```mcfunction
execute if score @s rx.pdb.has_entry matches 1 run ...
```

## Some admin features (for testing or for servers)

I recommend adding the `rx.admin` tag to you or other admins. This will provide more debug information and a cool load message (*Note that I use this for all my packs*)!

### Listing all the players stored in the database *(✨ Coming Soon ✨)*
    
This just pulls up a clickable tellraw menu for player `@s` in chat.

```mcfunction
function rx.playerdb:admin/list_players
```

Note that anyone can click these buttons, but only an operator can run this function.

### Admin tools for testing and for servers
    
```mcfunction
# This will nuke the database and all ids, no warning!
function rx.playerdb:admin/reset_all

# This will remove `@s`'s entry from the database
function rx.playerdb:admin/delete_player

# This will remove `$in.uid rx.playerdb.io`'s entry from the database
function rx.playerdb:admin/remove_entry

# This will take the data stored at rx.playerdb:temp admin.migrate.UUID
#  and 'migrate' the data to the entity called as @s
function rx.playerdb:admin/migrate_account
```

## More advanced API usage (events)

### Dynamically prepping entries when they are added
    
The function tag, `#rx.playerdb:api/v2/on_entry_add`, allows a function to be run when an entry is added. Just add your function in the tag. This function will fire before a `api/v2/get/self` completes it's execution allowing you to prep data for future use, very handy for a lean database!

The player will already be located at `rx.playerdb:io player` and will automatically save for you. There is no need to call any `api` functions and the datapack will bug you if you do!
    
```mcfunction
data modify storage rx.playerdb:io player.data.cool_pack set value {eggs: 0b}
# Starting with no eggs is :(
```
### Name changes: how to handle them
    
PlayerDB has a nifty feature of having data persist on a name change (no leftover data, etc), This allows you to cache your scoreboard scores, which are name specific, in the database.

Essentially, there is an event which fires when a player changes their name. When this occurs, you can take the scores stored in the database, and load them in the cooresponding scoreboards! All you need to do is save those scores to the database, and keep them updated.

There are two great ways of doing this:
1. Caching scores on a slow clock (maybe every 5 minutes)
2. Caching scores when they change

I prefer 2 since it leaves little to no room for error. If you wish to see an example of this, check out [Enderchest+](https://github.com/rx-modules/EnderChestPlus/blob/master/data/rx.ec/functions/setup.mcfunction).

```mcfunction
# I like to store the scores in a specific `scores` object so they are easy to identify
function #rx.playerdb:api/v2/get_self
execute store result storage rx.playerdb:io player.data.cool_pack.scores.eggs int 1 run scoreboard players get @s eggs
```

Once we implement this system, we have to implement a system to retrieve these scores when a name is changed. 

The function tag, `#rx.playerdb:api/v2/on_name_change`, allows a function to be ran when a player changes their name. This allows you to access the old name, `rx.playerdb:io old_name` and the data **if it has been created**.

```mcfunction
execute if score @s rx.pdb.has_entry matches 1 store result score @s eggs run data get storage rx.playerdb:io player.data.author.cool_pack.eggs
tellraw @a ["Yo, ", {"selector": "@s"}, " changed their name from ", {"storage": "rx:io", "nbt": "playerdb.old_name"}]
```

Make sure you prepend `execute if score @s rx.pdb.has_entry matches 1` to any `data get` you perform otherwise, you might just be getting null data (*which automatically gives 0 in Minecraft*).

Also, be sure not run to any `api` calls in here as well, since the datapack will again nag you ;)
