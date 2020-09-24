# By: rx97
# 24 Sept '20
# 
#> echest get

data modify storage rx:temp echest.items set from entity @s EnderItems
data modify storage rx:temp echest.items[0].tag.data.test set value 1b
# execute as @a[limit=10] run data modify storage rx:temp echest.items[0].tag.data.players append from entity @s Inventory
data modify block 0 0 0 Items set from storage rx:temp echest.items
loot replace entity @s enderchest.0 mine 0 0 0 air{drop_contents:1b}
