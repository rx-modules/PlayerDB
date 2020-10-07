# MC-PlayerDB - 1.16+ Minecraft Versions
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

This datapack assigns a unique id to each player via a scoreboard: rx.uid. In order to access the data, you need an uid to search the database with. Secondly, the database only creates an entry when it is requested or explicitly created.

Basic usage as follows:

    # This function will get `@s`'s current database entry
    # If you do not have an entry, it will create one for you
    function rx.playerdb:api/get_self

    # You can also get a different player's entry via a similiar method
    scoreboard players set $in.uid rx.io #
    function rx.playerdb:api/get
    
    # Now, the data I want to manipulate is in rx:io playerdb.player
    data modify storage rx:io playerdb.player.data set value {test:1b}
    
    # Afterwards, we can save this data..
    function rx.playerdb:api/save_self
    
    # And the alternative version for input via fakeplayer
    function rx.playerdb:api/save
    
    # If we need to list all the players in the database:
    function rx.playerdb:admin/list
    
    # Now, there are some handy admin tools
    function rx.playerdb:admin/reset_all  # WARNING, resets entire db
    function rx.playerdb:admin/delete_player # resets @s player
    function rx.playerdb:admin/remove_entry  # removes entry from $in.uid rx.io
    execute as player run function rx.playerdb:admin/replace_entry # replaces entry $in.uid rx.io w/ @s
 
 
## Some examples

[EnderChest+](https://github.com/RitikShah/EnderChestPlus)
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
