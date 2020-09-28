# By: rx97
# 24 Mar 2020
# 
#> Get Self Data

#> api add_entry, won't add unless we need to
function rx.playerdb:api/add_entry

#> grab the end uid just incase we *just* added an entry
scoreboard players operation $in.uid rx.io = @s rx.uid
execute store result score $uid rx.temp run data get storage rx:global playerdb.players[-1].info.uid

#> if end uid matches, the last entry is the io
execute if score $uid rx.temp = $in.uid rx.io run data modify storage rx:io playerdb.player.data set from storage rx:global playerdb.players[-1].data
execute if score $uid rx.temp = $in.uid rx.io run data modify storage rx:io playerdb.player.info set from storage rx:global playerdb.players[-1].info

#> else: actually get
execute unless score $uid rx.temp = $in.uid rx.io run function rx.playerdb:api/get
