# MC-PlayerDB - 1.15+ Minecraft Versions
A NBT Custom Player Database (Alpha)

This datapack provides a player database for you to utilize! What is this database? Let me explain:

Each player has an enderchest where the player can store and retrieve items. With commands, we can also place items, clear items, and even put loot tables in there! Each player has their own individual enderchest storage which is seperate from everyone elses. Essentially, this datapack implements a more feature filled version of a player enderchest. Using the new global nbt `storage` that was intoduced in 1.15, we can now store nbt data in the 'cloud'. This datapack maintains it's own space in this 'cloud' storing each player individually in a list.

## Why?

This datapack has two main advantages to enderchests:
* Accessing enderchest data requires the player to be online. This datapack has offline access.
* The enderchest can be accessed in survival. `storage` is a seperate entity w/ commands only access

## How to use

This datapack assigns a unique id to each player via a scoreboard: rx.uid. In order to access the data, you need an uid to search the database with (I'll talk later about searching with player names..)

Basic usage as follows:

    # set $in.uid rx.io as the number you want to search for
    # for this example, I'll just set it to my own uid
    scoreboard players operations $in.uid rx.io = @s rx.uid
    function rx:playerdbs/get
    
    # now, the data I want to manipulate is in rx:output root.player (if found)
    data modify storage rx:output root.player.data ...
    
    # after we have worked with this, we need to save this
    function rx:playerdbs/save
    # aaaand we are done!
    
    # if we only need to read the data, use fast_get as it's more optimized for reading, no need to save afterwards
    function rx:playerdb/fast_get
    
    # if we need to list all the players in the database:
    function rx:playerdb/list
    
    # maybe we want to work with @a uuids, let's grab the largest uid we want to filter down to
    execute as @a run scoreboard players operations $in.uid rx.io > @s rx.uid
    function rx:playerdb/filter
    # iterate through sublist @ rx:output root.filtered and do some data operations
    function rx:playerdb/save
 
 
## Some examples

* Store a different inventory per gamemode (creative, adventure, survival) **multiplayer compatible**
* Create a mailbox system where each player can mail each other items stored and retrievable offline (psst, coming soon)
* Store some stats about each player offline so other players can look you up even when you are offline

## Technical bits

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
 
