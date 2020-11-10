# By: rx97
# 14 Aug 20
# 
#> Checks version #load:load

#define entity @s
#define storage rx:global
#define storage rx:temp
#define storage rx:info
#define storage rx:io


#> Check if PlayerDB exists before us
execute if data storage rx:info playerdb.version run tellraw @a[tag=rx.admin] "Duplicate PlayerDB found, checking version"

#> Check exact version
execute if data storage rx:info playerdb.version unless data storage rx:info playerdb.version{major:0, minor:8} run tellraw @a "Old PlayerDB version found. Please remove all PlayerDB versions except one. The current version is PlayerDB v0.8-beta"

#> If PlayerDB doesn't exist, good to go!
execute unless data storage rx:info playerdb.version run function rx.playerdb:init
