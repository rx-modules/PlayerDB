# By: rx97
# 14 Aug 20
# 
#> Checks version #load:load

#define entity @s
#define storage rx:global
#define storage rx:temp
#define storage rx:info
#define storage rx:io

#> Info!
data modify storage rx:info playerdb.name set value 'PlayerDB'
data modify storage rx:info playerdb.pretty_name set value '[{"text":"P","color":"#dd9b14"},{"text":"l","color":"#df9412"},{"text":"a","color":"#e18e10"},{"text":"y","color":"#e3880e"},{"text":"e","color":"#e5810c"},{"text":"r","color":"#e77b0a"},{"text":"D","color":"#e97508"},{"text":"B","color":"#eb6f07"}]'

#> Upgrade? I chk the $256 bc none of my other datapacks have that
execute unless data storage rx:info playerdb.version if score $256 rx.int matches 256 run function rx.playerdb:impl/update/v07tov08

function rx.playerdb:init
