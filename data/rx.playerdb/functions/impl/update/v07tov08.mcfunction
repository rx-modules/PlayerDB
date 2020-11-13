# By: rx97
# 09 Nov 20
# 
#> Update base 2 to base 64

execute store result score $loop rx.temp if data storage rx:global playerdb.players[]
execute if score $loop rx.temp matches 1.. run function rx.playerdb:impl/update/v07to08/_iter

tellraw @a [{"text":"", "color":"gray"}, {"text":"P","color":"#dd9b14"},{"text":"l","color":"#df9412"},{"text":"a","color":"#e18e10"},{"text":"y","color":"#e3880e"},{"text":"e","color":"#e5810c"},{"text":"r","color":"#e77b0a"},{"text":"D","color":"#e97508"},{"text":"B","color":"#eb6f07"}, " successfully updated to v0.8"]
