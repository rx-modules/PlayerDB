# By: rx97
# 03 Nov 20
# 
#> @s: 
#> Does actual init

#> LL Load + version
scoreboard players set rx.PlayerDB load 1

data modify storage rx:info playerdb.version set value {major: 1, minor: 0, patch: 1}
scoreboard players set rx.PDB.major load 1
scoreboard players set rx.PDB.minor load 0
scoreboard players set rx.PDB.patch load 1

data modify storage rx:info playerdb.pretty_version set value '[{"storage": "rx:info", "nbt": "playerdb.version.major"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.minor"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.patch"}]'

scoreboard objectives add rx.io dummy
scoreboard objectives add rx.uid dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy

scoreboard objectives add rx.pdb.list dummy
scoreboard objectives add rx.pdb.HasEntry dummy

scoreboard objectives add rx.pdb.LT trigger
scoreboard objectives add rx.pdb.login minecraft.custom:minecraft.leave_game

#> 0.8+: uuid storage
scoreboard objectives add rx.uuid0 dummy
scoreboard objectives add rx.uuid1 dummy
scoreboard objectives add rx.uuid2 dummy
scoreboard objectives add rx.uuid3 dummy

#> only sets if unset ;)
execute unless score $uid.next rx.uid matches -2147483648.. run scoreboard players set $uid.next rx.uid 1

scoreboard players set $2 rx.int 2
scoreboard players set $3 rx.int 3
scoreboard players set $16 rx.int 16
scoreboard players set $19 rx.int 19
scoreboard players set $64 rx.int 64
scoreboard players set $256 rx.int 256

#> start our tick loop
schedule function rx.playerdb:tick 1t replace

#> cool admin msg is cool
tellraw @a[tag=rx.admin] [{"text":"", "color":"gray"}, {"nbt": "playerdb.pretty_name", "storage": "rx:info", "interpret": true}, " ", {"storage": "rx:info", "nbt": "playerdb.pretty_version", "interpret": true}, " loaded"]
