# By: rx97
# 01 Dec 20
# 
#> @s: player
#> Spits out a bunch of debug information to admins. WARNING CHAT SPAM.

#> Steps:
#>  1. (Optional) Clear logs.
#>  2. Run this function.
#>  3. Copy logs and throw it into pastebin (or alt)
#>  4. Send me a link w/ bug description

#define storage rx:debug
data modify storage rx:debug playerdb set from storage rx:global playerdb
data remove storage rx:debug playerdb.players[].data

tellraw @a[tag=rx.admin] ["", {"storage": "rx:info", "nbt": "playerdb.pretty_name", "interpret": true}, " ", {"storage": "rx:info", "nbt": "playerdb.pretty_version", "interpret": true}]
tellraw @a[tag=rx.admin] ["", {"color": "gold", "text": "rx.uuid0: "}, {"score": {"name": "@s", "objective": "rx.uuid0"}}, ", ", {"color": "gold", "text": "uid: "}, {"score": {"name": "@s", "objective": "rx.uid"}}, ", ", {"color": "gold", "text": "HasEntry: "}, {"score": {"name": "@s", "objective": "rx.pdb.HasEntry"}}]

tellraw @a[tag=rx.admin] ["", {"color": "gold", "text": "current player: "}, {"storage": "rx:debug", "nbt": "playerdb.players[{selected:1b}]"}]

tellraw @a[tag=rx.admin] ["", {"color": "gold", "text": "playerdb.players: "}, {"storage": "rx:debug", "nbt": "playerdb.players"}]
tellraw @a[tag=rx.admin] ["", {"color": "gold", "text": "playerdb.uuid: "}, {"storage": "rx:debug", "nbt": "playerdb.uuid"}]
