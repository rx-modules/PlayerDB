# PlayerDB - 1.16+ Minecraft Versions
A NBT Custom Player Database (Beta)

This datapack provides a player database for you to utilize! What is this database? Let me explain:

Each player has an enderchest where the player can store and retrieve items. With commands, we can also place items, clear items, and even put loot tables in there! Each player has their own individual enderchest storage which is seperate from everyone elses. Essentially, this datapack implements a more feature filled version of a player enderchest. Using the new global nbt `storage` that was intoduced in 1.15, we can now store nbt data in the 'cloud'. This datapack maintains it's own space in this 'cloud' storing each player individually in a list. Like how scoreboard stores numbers per player, here you can store nbt per player allowing you to manage and manipulate it as you please (even access it when they are offline!)

## Why?

At the moment, the only thing we really have per player are scoreboards which only store numbers and enderchests which store items (mostly for survival). This new system adds another per player storage... custom nbt! This ranges from numbers, floats, strings, lists, and compounds of all these elements combined!

This datapack has a couple main advantages to enderchests:
* Accessing enderchest data requires the player to be online. This datapack has offline access.
* The enderchest can be accessed in survival. `storage` is a seperate entity w/ commands only access
* This datapack *should* be **much** faster than accessing the enderchest. This is because accessing the enderchest requires **serialization** which incurs steep performance costs. The nbt `storage` does not store serialized, only compressed as nbt.

There are a couple of alternative implementations of player-specific nbt storage:
* Using a single array and iterating through all the elements until you find the player.
* * This is particularly laggy and scales O(n) for the number of players in the list
* * PlayerDB scales O(log(n)) and it many more optimized with lower uid numbers.
* Creating a custom dimension (or isolating a chunk) for an array of jukeboxes.
* * Since jukeboxes are BlockEntities, they incur extra lag as well.
* * This is one of the best other solutions which you can check out here: [EntityDB](https://github.com/hqics/entitydb)
* * From my slight testing, PlayerDB does beat out in terms of lag, but this may vary.

## Lag?

As previously mentioned, this solution is an alternative to other solutions which may be laggier. To be specific, at worst, it is O(log(n)) which while not at O(1) like a normal array, is pretty damn close. In terms of minecraft, you can think of this being about 50% less laggier than getting the player nbt via `data get entity @s` (which has been moderately tested so do try yourself). More technical bits on lag will be discussed in a later section.

## How to use

This datapack assigns a unique id to each player via a scoreboard: rx.uid. In order to access the data, you need an uid to search the database with. Secondly, the database only creates an entry when it is requested or explicitly created. I've listed some examples ranging from easy to complex.

<details>
<summary>Storing simple data</summary>

This will get `@s`'s database entry. If it does not exist, it'll dynamically create it

    function rx.playerdb:api/get_self

Our data is available at rx:io playerdb.player.data. We should write some data, notice how we organized our data by author.cool_pack

    data modify storage rx:io playerdb.player.data.author.cool_pack set value {eggs: 3b}

Note that we stored our data in `author.cool_pack`. Namespacing our data allows us to have better compatibility with other packs!

Finally, let's save our data!

    function rx.playerdb:api/save_self

</details>

<details>
<summary>Getting some previously stored data</summary>

    function rx.playerdb:api/get_self
    execute store result score @s eggs run data get storage rx:io playerdb.player.data.author.cool_pack.eggs

    # No need to save, we are just reading

</details>

<details>
<summary>Getting someone else's data</summary>
    
Sometimes, we don't want to get our own data, but someone elses. Let's say that we have someone else's id stored in author.obj

    scoreboard players operation $in.uid rx.io = @s author.obj

    # Note that we are using `api/get` here, `get` will **not** make a new entry on the fly
    function rx.playerdb:api/get

    # Let's hope they had some eggs stored, I was running out
    execute store result score @s eggs run data get storage rx:io playerdb.player.data.author.cool_pack.eggs

    # No need to save, we are just reading someone else's data ;)
    # If we were to... steal some eggs, we could save that change via:
    #     function rx.playerdb:api/save

</details>

<details>
<summary>Misc Things</summary>
    
We can manually add a player entry for `@s` via
    
    function rx.playerdb:api/add_entry

We can also 'select' our data for `$in.uid rx:io`
This exposing some internal logic, essentially outputs an entry @ rx:global playerdb.players[{selected:1b}]
This does interface with the live database, so you'll wanna becareful if you are using this

    scoreboard players operation $in.uid rx.io = @s rx.uid
    function rx.playerdb:api/select

    # (Note: select is much faster than a `get`/`save` which is why I've included in the api)

We can check whether or not a player a database entry. This incentivizes not creating a db entry for every player, but rather creating them dynamically when you need them. You can hook into the `#api/on_entry_add` function tag which is talked about in a later section.

    execute if score @s rx.pdb.HasEntry matches 1 run ...

Finally, if you want to see some debug info..

    tag @s add rx.admin

This will provide more debug information and a cool load message (*Note that I use this for all my packs*)!

</details>

<details>
<summary>Listing all the players stored in the database</summary>
    
This just pulls up a clickable tellraw menu for player `@s` in chat

    function rx.playerdb:admin/list

Note that anyone can click these buttons, but only an operator can run this function

</details>

<details>
<summary>Admin tools for testing and for servers</summary>
    
    function rx.playerdb:admin/reset_all      # This will nuke the database and all ids, no warning!
    function rx.playerdb:admin/delete_player  # This will remove `@s`'s entry from the database
    function rx.playerdb:admin/remove_entry   # This will remove `$in.uid rx.io`'s entry from the database

</details>

<details>
<summary>Dynamically prepping entries when they are added</summary>
    
The function tag, `#rx.playerdb:api/on_entry_add`, allows a function to be ran when an entry is added. Just plop a function tag with the function you want to fire. This function will fire before a `api/get_self` completes allowing you to intercept the creation ;)

The player data will already be stored in rx:io playerdb.player.data and will automatically save for you. Do **not** call `api/save_self`, just modify the data!
    
    data modify storage rx:io playerdb.player.data.author.cool_pack set value {eggs: 0b}  # No eggs :(

</details>

<details>
<summary>Name changes: how to handle them</summary>
    
PlayerDB has a nifty feature of having data persist on a name change (no leftover data, etc), This allows you to cache your scoreboard scores, which are name specific, in the database. 

There are two great ways of doing this:
1. Caching scores on a slow clock (maybe every 5 minutes)
2. Caching scores when they change

I prefer 2 since it leaves little to no room for error. If you wish to see an example of this, check out [Enderchest+](https://github.com/rx-modules/EnderChestPlus/blob/master/data/rx.ec/functions/setup.mcfunction)

    # I like to store the scores in a specific `scores` object so they are easy to identify
    function rx.playerdb:api/get_self
    execute store result data storage rx:io playerdb.player.data.author.cool_pack.scores.eggs run scoreboard players get @s eggs

Once we implement this system, we have to implement a system to retrieve these scores when a name is changed. 
The function tag, `#rx.playerdb:api/on_name_change`, allows a function to be ran when a player changes their name. This allows you to access the old name, `rx:io playerdb.old_name` and the data **if it has been created**.

    execute if score @s rx.pdb.HasEntry matches 1 store result score @s eggs run data get storage rx:io playerdb.player.data.author.cool_pack.eggs
    tellraw @a ["Yo, ", {"selector": "@s"}, " changed their name from ", {"storage": "rx:io", "nbt": "playerdb.old_name"}]

Make sure you prepend `execute if score @s rx.pdb.HasEntry matches 1` to any `data get` you perform otherwise, you might just be getting null data (which automatically gives 0 in minecraft)


</details>


## Lantern Load

This project uses [Lantern Load](https://github.com/LanternMC/Load). This allows you to ensure your datapack loads after library to ensure you are able to use everything this datapack provides. You can also detect whether this library is loaded by checking `if score PlayerDB load matches 1..`. Note: You don't necessarily need to use Lantern Load for your pack, since using this pack is more often happening in a ticking function instead of on load.  

### Example

Once you've copied `Load` into your datapack, navigate to the `#load:load` function tag. This should simulate the contents of the function tag (note, you can add more dependancies if you have them):

    {
        "values": [
            "#load:rx/playerdb",
            "#load:<namespace>/<datapack>"
        ]
    }

Then, make sure you have defined an empty `#load:rx/playerdb` and in your own `#load` tag, you should define your personal load function. This will ensure PlayerDB's load will occur before yours. If PlayerDB does not exist, load will continue and you can detect this by checking the `PlayerDB load` score. For an example of all of this, checkout [EnderChest+](https://github.com/rx-modules/EnderChestPlus/tree/master/data/load) as an example of a datapack relying on PlayerDB.


## Some examples

[EnderChest+](https://github.com/rx-modules/EnderChestPlus)
This datapack allows for expandable EnderChests with complete multiplayer compatability!

## Technical bits

Every player is given a unique id scoreboard, `rx.uid`. This is a number that starts counting from 1, `$uid.next rx.uid`, and every player gets an incrementing number. When a player wants to create a new entry via `api/add_entry` or `api/get_self` (which creates an entry for you), a new nbt compound is added a list located at `rx:global playerdb.players`. Each player data is organized as so: `{selected: 0b, info:{name: '<player name>', uid: <scoreboard uid>, UUID: <player UUID>}, data:{...}, bit0: xb, bit1: xb, ..., bitn: xb}`. When a player is given a uid, bits will be generated inside the entry `bit0: xb` based on the binary breakdown of the uid. This is used for the selection/filtering algorithm.

When a `get` or `save` operation is called, the program will filter down the database to select the correct entry to the input uid via `@s rx.uid` or `$in.uid rx.io`. The filtering process is really unique and this is the crux of the entire library so I'll describe it in more detail.

When you run a `get` or `save`, you will most likely trigger a selection algorithm (`impl/select`). Essentially, this modifies every entry's `selected` nbt to 1b. The system will then call the `bit0` filtering function which determines the first bit of the `uid` and modifies all entries `selected` nbt to 0b if they don't match. If there are more than 1 entries with `selected:1b`, it will continue to the next bit, else it will short-circuit and stop. At the end of the selection process, there should be either 0 or 1 entries in the database with `selected:1b` which u can select via `rx:global playerdb.players[{selected:1b}]`.

Saving will usually filter (although there's some optimizations to skip that if you perform a get and a save right next to each other) and then just replace the entry while get just copies the entry into `rx:io`.


## Shoutouts

* Speedy2025#2025 - Helped me test it to make sure I never broke it. Biggest supporter lmao!
* the der discohund#8028 - Biggest boost on optimization (selection > copying)
* nphhpn#0575 - Gave me some advice on optimizations!
* AmberW#4615 - She threw out the initial idea and I've built on from that
* vdvman1#9510 - For helping me figure out some of the nbt manipulation nonsense (and some optimizations)
* [r/minecraftcommands discord](https://discord.gg/QAFXFtZ) - Pretty helpful w/ feedback and good community, check it out!


## Endnote

This datapack was a calling to one of the more annoying issues with custom nbt in Minecraft: dynamic list indexing. While 1.14 gave us an amazing command, `data modify`, allowing us to modify the deeper details of nbt, and 1.15 giving us `data storage` allowing us to store arbituary nbt 'in the cloud', we still struggle with a couple of things, namely, indexing. There is no way to index into a NBT List based on a scoreboard value. This means if we needed to store a list of entries tied to a scoreboard, we would be forced to iterate through the entries which is an O(n) solution to a traditionally O(1) solution in most programming languages.

The smart folk over at [r/minecraftcommands discord](https://discord.gg/QAFXFtZ) came up with various solutions to solve this problem and this datapack is one solution that I've grown quite fond over. While I like the usefulness of this library, I've mostly been wanting to understand some of the weird problems that Minecraft throws at us.

This stuff is pretty hard to work through and somewhat hard to envision, but essentially, this is a player database that you can easily use. It's a pretty technical thing, but hopefully the API is not too hard to use. If you have any questions, create a github issue or hit me up on discord @ rx#1284. I'm very active on [r/minecraftcommands discord](https://discord.gg/QAFXFtZ) as well
