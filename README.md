# PlayerDB - 1.17+
An NBT Custom Player Database

> Hello everyone! The most recent v2.0.0 update was pretty large and changed almost every single name throughout the pack. While your data will be migrated, you will have to update your API calls etc.
> 
> This is due to a brand new feature called bundling which I discuss later on. Please join my [Discord](https://discord.rx97.dev/) if you have any questions!

PlayerDB is a database solution which allows you to store more data per player. *What does this mean?* Let me explain:

Consider the Ender Chest. Every player has access to a **player** specific inventory where you save your stuff without anyone being able to snoop around. This chest lives in the "cloud" which allows you to access it anywhere in the world at any time making it very convenient to access your favorite items!

This datapack implements a feature-rich version of the Ender Chest for the use for creators! Through a global nbt feature called `storage`, introduced in 1.15, PlayerDB stores arbitrary NBT data, such as Ender Chest items, in a really efficient manner. Each player can then be tied to a section of this "cloud" akin to how we access scores via the `scoreboard` command! You can manipulate this data however you please, and even access it offline!

## Why?

At the moment, the only thing we really have per player are scoreboards which only store numbers and Ender Chests which store items (mostly in survival). This new system adds another per player storage... custom nbt! This ranges from numbers, floats, strings, lists, and compounds of all these elements combined!

This datapack has a couple main advantages to Ender Chests:
* Accessing Ender Chest data requires the player to be online. This datapack has offline access.
* The Ender Chest can be accessed in survival. `storage` is a separate thing only commands can access
* This datapack is **much** faster than accessing Ender Chest data. This is because accessing the Ender Chest requires **serialization** which incurs steep performance costs. The NBT `storage` does not store serialized data, only compressed in the NBT format.

There are a couple of alternative implementations of player-specific nbt storage:
* Using a single array and iterating through all the elements until you find the player.
> This is particularly laggy and scales O(n) for the number of players in the list while 
> PlayerDB scales O(log n) and it much more optimized with lower uid numbers.

* Creating a custom dimension (or isolating a chunk) for an array of jukeboxes.
> Since jukeboxes are BlockEntities, they incur extra lag as well. 
> This is one of the best other solutions which you can check out here: [EntityDB](https://github.com/hqics/entitydb)
> From my slight testing, PlayerDB **does** beat out in terms of lag, but this is based off my limited testing.

**New**
* Summoning a new `marker` entity per player and connecting them with a unique scoreboard score
> While this method is pretty clean since referencing entities can look very clean, there are still issues with this.
1. PlayerDB stores all the data in `storage` NBT files in the `data` directory which can be easy to access with external tools esp in backing up the database specifically
2. `marker` entities need to link in a specific chunk.
    a) If the chunk is always loaded, they will clog up `@e` commands, esp on servers where many new players join creating new entities.
    b) If the chunk isn't loaded, then you have to load the chunk when you access the data which doesn't make the data immediately available due to entity loading being asynchronous.
3. Storing a large amount of data there could corrupt your chunk. Boq, a developer at Mojang warned about this over in the MinecraftCommands discord [here](https://canary.discord.com/channels/154777837382008833/593812273164976166/831955643568619561).
> Due to these cons, I find that PlayerDB ends up being a great solution, with a plus of having no persistent entities.

## Lag?

As previously mentioned, this solution is designed to be very well optimized. To be specific, at worst, it is O(log(n)) which while not at O(1) like a normal array, is pretty damn close. In terms of Minecraft, you can think of this being about 50% less laggy than getting the player nbt via `data get entity @s` (which has been moderately tested, so do try yourself). More technical bits on lag will be discussed in a later section.


## Lantern Load

This project uses [Lantern Load](https://github.com/LanternMC/Load). This allows you to ensure your datapack loads after library to ensure you can use everything this datapack provides. You can also detect whether this library is loaded by checking `if score PlayerDB load.status matches 1..`. Check out the Usage tab for more details on how this convention helps!


### Versioning

You can detect the version of the datapack via two methods:

a) The version is stored in `storage`. `rx:info playerdb.version` as `major`, `minor`, and `patch`.

b) The version is also available in the `load.status` scoreboard under:
    - `#rx.playerdb.major`
    - `#rx.playerdb.minor`
    - `#rx.playerdb.patch`


## Some examples

[EnderChest+](https://github.com/rx-modules/EnderChestPlus)
This datapack allows for expandable EnderChests with complete multiplayer compatibility!


## Shoutouts

* You :) - For checking out my GH page :D!
* Speedy2025#2025 - Helped me test it to make sure I never broke it.
* the der discohund#8028 - Biggest boost on optimization (selection > copying)
* nphhpn#0575 - Gave me some advice on optimizations!
* AmberW#4615 - She threw out the initial idea and I've built on from that.
* vdvman1#9510 - For helping me figure out some of the nbt manipulation nonsense (and some optimizations).
* [fizzy](https://github.com/vberlier) - Helpful in my migration to `beet`
* [r/minecraftcommands discord](https://discord.gg/QAFXFtZ) - Pretty helpful w/ feedback and a great community, check it out!


## Endnote

This datapack was a calling to one of the more annoying issues with custom nbt in Minecraft: dynamic list indexing. While 1.14 gave us an amazing command, `data modify`, allowing us to modify the deeper details of nbt, and 1.15 giving us `data storage` allowing us to store arbitrary nbt 'in the cloud', we still struggle with a couple of things, namely, indexing. There is no way to index into an NBT List based on a scoreboard value. This means if we needed to store a list of entries tied to a scoreboard, we would be forced to iterate through the entries which is an O(n) solution to a traditionally O(1) solution in most programming languages.

The smart folk over at [r/minecraftcommands discord](https://discord.gg/QAFXFtZ) came up with various solutions to solve this problem and this datapack is one solution that I've grown quite fond over. While I like the usefulness of this library, I've mostly been wanting to understand some of the weird problems that Minecraft throws at us.

This stuff is pretty hard to work through and somewhat hard to envision, but essentially, this is a player database that you can easily use. It's a pretty technical thing, but hopefully, the API is not too hard to use. If you have any questions, create a GitHub issue or join my discord [here](https://discord.gg/zhadd6GHWJ).
