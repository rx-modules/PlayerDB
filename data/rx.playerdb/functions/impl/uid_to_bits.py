import math

BASE = 3
MAX_INT = 2**31-1
DEBUG = True

comment = (
    '# By: rx97\n'
    '# 10 Aug 2020\n'
    '# \n'
    '#> Make the player entry\n'
)

lines = {
    'bit': 'scoreboard players operation $bit rx.temp = $uid rx.temp',
    'storage': 'execute store result storage rx:global playerdb.players[-1].bits.bit{bit} byte 1 run scoreboard players operation $bit rx.temp %= ${base} rx.int',
    'debug': '# tellraw @s [{"text":"", "color":"gold"}, {"text":"bit{bit}: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]',
}

out = [comment]
for i in range(0, int(math.log(MAX_INT, BASE)) + 1):
    out.append(lines['bit'])
    out.append(lines['storage'].format(bit=i, base=BASE))
    if DEBUG:
        out.append(lines['debug'])
    out.append('\n')

with open(f'uid_to_bits.mcfunction', 'w') as file:
    file.write('\n'.join(out))
