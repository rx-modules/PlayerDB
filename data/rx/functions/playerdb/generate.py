BASE = 3

comment = (
    '# By: shraavan97\n'
    '# 14 Nov 2019\n'
    '# \n'
    '#> Make the player entry\n'
)

lines = ['scoreboard players operation $bit rx.temp = $uid rx.temp',
'execute store result storage rx:global playerdb.players[-1].bit{bit} byte 1 run scoreboard players operation $bit rx.temp %= ${base} rx.int',
'# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit{bit}: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]']

out = [comment]
for i in range(0, 999):
    if i ** BASE > (2**31-1):
        break
    out.append(lines[0])
    out.append(lines[1].format(bit=i, base=BASE))
    out.append(lines[2])

with open(f'uid_to_bits.mcfunction', 'w') as file:
    file.write('\n'.join(out))
