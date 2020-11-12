# By: rx97
# 1 Oct 20
# 
#> Verify selected is 1 and correct uid
#> input: $uid rx.temp
#> output: $verified rx.temp 0/1 (0: failed, 1: success)

#> get size
execute store result score $size rx.temp if data storage rx:global playerdb.players[{selected:1b}]

#> get uid
execute store result score $uid.check rx.temp run data get storage rx:global playerdb.players[{selected:1b}].info.uid

#> stores 1 in $verified if:
#> - $size == 1
#> - $uid == $uid.check
execute store result score $verified rx.temp if score $size rx.temp matches 1
execute if score $verified rx.temp matches 1 store result score $verified rx.temp if score $uid rx.temp = $uid.check rx.temp

#> clean up
scoreboard players reset $uid.check rx.temp
