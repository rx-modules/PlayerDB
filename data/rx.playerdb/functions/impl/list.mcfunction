# By: rx97
# 14 Aug 20
# 
#> Lists all players

#> Colors
# gold - primary
# #4F000B (rosewood) - secondary
# #720026 (claret), #CE4257 (brick red), #DAD6D6 (light gray) - accents

data modify storage rx:temp playerdb.players set from storage rx:global playerdb.players

tellraw @s [{"text":"UID: ", "color": "gold", "bold": true}, {"text": "Player", "color":"#CE4257"}]
execute if data storage rx:temp playerdb.players run function rx.playerdb:impl/list_iter

data modify storage rx:temp playerdb set value {}
