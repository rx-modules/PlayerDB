# By: shraavan97
# 17 Nov 2019
# 
#> Save data

execute if data storage rx:output root.player run data modify storage rx:output root.leftover append from storage rx:output root.player
data modify storage rx:global root.players set from storage rx:output root.leftover

data modify storage rx:output root set value {}
