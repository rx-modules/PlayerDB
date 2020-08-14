# MC-PlayerDB - 1.16+ Minecraft Versions (May work for 1.15)
A NBT Custom Player Database (Beta)

This datapack provides a player database for you to utilize! What is this database? Let me explain:

Each player has an enderchest where the player can store and retrieve items. With commands, we can also place items, clear items, and even put loot tables in there! Each player has their own individual enderchest storage which is seperate from everyone elses. Essentially, this datapack implements a more feature filled version of a player enderchest. Using the new global nbt `storage` that was intoduced in 1.15, we can now store nbt data in the 'cloud'. This datapack maintains it's own space in this 'cloud' storing each player individually in a list.

## Why?

Atm, the only thing we really have per player are scoreboards which only store numbers and enderchests which store items (mostly for survival). This new system adds another per player storage... custom nbt! This ranges from numbers, floats, strings, lists, and compounds of all these elements combined!

This datapack has a couple main advantages to enderchests:
* Accessing enderchest data requires the player to be online. This datapack has offline access.
* The enderchest can be accessed in survival. `storage` is a seperate entity w/ commands only access
* This datapack *should* be **much** faster than accessing the enderchest. This is because accessing the enderchest requires **serialization** which incurs steep performance costs. The nbt `storage` does not store serialized, only compressed as nbt.

There are a couple of alternative implementations of player-specific nbt storage:
* Using a single array and iterating through all the elements until you find the player
* * This is particularly laggy and scales O(1) for each player in the list.
* * PlayerDB scales O(log(n)) and is even more optimized for a player count less than 64 and 4096
* Creating a custom dimension (or isolating a chunk) for an array of jukeboxes.
* * Since jukeboxes are BlockEntities, they incur extra lag as well.
* * I have not yet tested PlayerDB against this method

## Lag?

As previously mentioned, this solution is signifiantly less laggier than other solutions floating around (testing coming soon™). To be specific, at worst, it is O(log(n)) which while not at O(1) like a normal array, is pretty damn close. There are also some optimization tricks done to help cut down on the amount of commands to run when dealing with a player base of less than first 64 players, 4096 players, 262,144 players, etc. This allows the datapack to only take \~30cmds to get an entry for a player and \~40cmds to save an entry for a player when you are working with players under 64.

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
    
    # If we need to list all the players in the database:
    function rx.playerdb:api/list
    
    # Now, there are some handy admin tools
    function rx.playerdb:admin/reset  # WARNING, resets entire db
    function rx.playerdb:admin/reset_player # resets @s player
    function rx.playerdb:admin/remove  # removes entry from $in.uid rx.io
 
 
## Some examples

* Store a different inventory per gamemode (creative, adventure, survival) **multiplayer compatible**
* Create a mailbox system where each player can mail each other items stored and retrievable offline (psst, coming soon)
* Store some stats about each player offline so other players can look you up even when you are offline

## Technical bits

#> TODO FIX

The main reason why this datapack was built was to utilize a technique talked about in the [r/minecraftcommands discord](https://discord.gg/QAFXFtZ). With nbt lists in minecraft, we don't have the best access to arbiturary values in a list so we are forced to iterate through the entire list and check if we have found our entry we wish to edit. This is really slow and can blow up if the list becomes very, very large. There are some optimizations one can do with iteration, but in the end, it is based on O(n) amount of players (and each iteration requires multiple nbt operations ^^^ cost.

Solution: store the bits of the uid alongside the data and use `players[{bit0:0/1}]` nbt searching to filter the list. We can repeat this filter for each bit which will single us down to a single value. This is a static amount of operations no matter how many players we are dealing with! Along with this, this datapack features some optimizations at lower uid values (naturally, those values will be lower) which will also make getting player data from the database very cheap!

The datapack stores all the players @ `rx:global root.players` in a single list. This makes iteration still very possible, so if you want, you can iterate through and do name matching if you like. You can also use the `filter` function to remove all entries with higher bits set which can give you a much smaller sublist to iterate through.

## Shoutouts

* nphhpn#0575 - Lots of help on the rewrite! Big optimization help!
* AmberW#4615 - She threw out the initial idea and I've built on from that
* vdvman1#9510 - For helping me figure out some of the nbt manipulation nonsense (and some optimizations)
* [r/minecraftcommands discord](https://discord.gg/QAFXFtZ) - Pretty helpful w/ feedback and good community, chk it out!


## Endnote

This stuff is pretty hard to work through and somewhat hard to envision, but essentially, this is a player database that you can easily use. It's a pretty technical thing, but hopefully the API is not too hard to use. If you have any questions, create a github issue or hit me up on discord @ rx#1284. I'm very active on [r/minecraftcommands discord](https://discord.gg/QAFXFtZ) as well
 
