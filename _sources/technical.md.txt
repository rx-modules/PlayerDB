## Technical bits

```{admonition} 🚧 In Construction 🚧
:class: warning

Some details in this doc are out of date!
```

Every player is given a unique id scoreboard, `rx.uid`. This is a number that starts counting from 1, `$uid.next rx.uid`, and every player gets an incrementing number. When a player wants to create a new entry via `api/add_entry` or `api/get_self` (which creates an entry for you), a new nbt compound is added a list located at `rx.playerdb:main players`. Each player data is organized as so: `{selected: 0b, info:{name: '<player name>', uid: <scoreboard uid>, UUID: <player UUID>}, data:{...}, bit0: xb, bit1: xb, ..., bitn: xb}`. When a player is given a uid, bits will be generated inside the entry `bit0: xb` based on the binary breakdown of the uid. This is used for the selection/filtering algorithm.

When a `get` or `save` operation is called, the program will filter down the database to select the correct entry to the input uid via `@s rx.uid` or `$in.uid rx.playerdb.io`. The filtering process is really unique and this is the crux of the entire library so I'll describe it in more detail.

When you run a `get` or `save`, you will most likely trigger a selection algorithm (`impl/select`). Essentially, this modifies every entry's `selected` nbt to 1b. The system will then call the `bit0` filtering function which determines the first bit of the `uid` and modifies all entries `selected` nbt to 0b if they don't match. If there are more than 1 entries with `selected:1b`, it will continue to the next bit, else it will short-circuit and stop. At the end of the selection process, there should be either 0 or 1 entries in the database with `selected:1b` which u can select via `rx.playerdb:main players[{selected:1b}]`.

Saving will usually filter (although there are some optimizations to skip that if you perform a get and a save right next to each other) and then just replace the entry while get just copies the entry into `rx:io`.
