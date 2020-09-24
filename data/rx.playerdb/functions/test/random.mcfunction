# From: AESTD
# 
# Altered by rx97
# June 23 2020

#> Input:
#>  entity: @s random_range (exclusive)
#>  entity: @s random_min (inclusive)
#>  fakeplayer: $max random
#>  fakeplayer: $min random
#> 
#> Output:
#>  entity: @s random
#>  fakeplayer: $output random  


scoreboard players set $multiplier random 1630111353
scoreboard players set $increment random 1623164762
scoreboard players set $modulus random 2147483647


execute unless score $max random = $max random if entity @s run scoreboard players operation $max random = @s random.range
execute unless score $min random = $min random if entity @s run scoreboard players operation $min random = @s random.min

scoreboard players operation $range random = $max random
scoreboard players operation $range random -= $min random
scoreboard players operation $range random *= $16 rx.int

scoreboard players operation $seed random *= $multiplier random
scoreboard players operation $seed random += $increment random
scoreboard players operation $seed random %= $modulus random

scoreboard players operation $output random = $seed random
scoreboard players operation $output random %= $range random
scoreboard players operation $output random /= $16 rx.int
scoreboard players operation $output random += $min random

execute if entity @s run scoreboard players operation @s random = $output random

scoreboard players reset $max random
scoreboard players reset $min random

# execute if entity @s run scoreboard players set @s random.min 0
