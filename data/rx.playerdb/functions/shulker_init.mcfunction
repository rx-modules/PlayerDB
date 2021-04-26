# By: rx97
# 03 Nov 20
# 
#> @s: 
#> Does actual init

data modify storage rx:info playerdb.name set value 'PlayerDB'
data modify storage rx:info playerdb.pretty_name set value '[{"text":"P","color":"#dd9b14"},{"text":"l","color":"#df9412"},{"text":"a","color":"#e18e10"},{"text":"y","color":"#e3880e"},{"text":"e","color":"#e5810c"},{"text":"r","color":"#e77b0a"},{"text":"D","color":"#e97508"},{"text":"B","color":"#eb6f07"}]'

data modify storage rx:info playerdb.version set value {major: 1, minor: 1, patch: 0}
data modify storage rx:info playerdb.pretty_version set value '[{"storage": "rx:info", "nbt": "playerdb.version.major"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.minor"}, ".", {"storage": "rx:info", "nbt": "playerdb.version.patch"}]'

scoreboard objectives add load dummy
scoreboard players set rx.pdb.major load 1
scoreboard players set rx.pdb.minor load 1
scoreboard players set rx.pdb.patch load 0

scoreboard objectives add rx.io dummy
scoreboard objectives add rx.int dummy
scoreboard objectives add rx.temp dummy

scoreboard objectives add rx.pdb.list dummy
scoreboard objectives add rx.pdb.HasEntry dummy

scoreboard objectives add rx.pdb.LT trigger
scoreboard objectives add rx.pdb.login minecraft.custom:minecraft.leave_game

#> 0.8: uuid storage
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

#> cool admin msg is cool
tellraw @a[tag=rx.admin] [{"text":"", "color":"gray"}, {"nbt": "playerdb.pretty_name", "storage": "rx:info", "interpret": true}, " ", {"storage": "rx:info", "nbt": "playerdb.pretty_version", "interpret": true}, " loaded"]
