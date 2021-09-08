# By: rx97
# 24 Sept '20
# 
#> echest get

data modify storage rx:temp echest.items set from entity @s EnderItems
data modify storage rx:temp echest.output set from storage rx:temp echest.items[0].tag.data
