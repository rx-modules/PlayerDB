# By: rx97
# 14 Aug 20
# 
#> Save after Select

data modify storage rx:global playerdb.players[{selected:1b}].data set from storage rx:io playerdb.player.data
