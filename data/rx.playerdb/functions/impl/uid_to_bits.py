from datetime import datetime
import math

BASE = 64
MAX_INT = 2**31-1
DEBUG = False


COMMENT = (
    '# By: rx97\n'
    # f"# Generated on: {datetime.now().strftime(r'%d %b %y')}\n\n"
)

lines = (
    f'scoreboard players operation $uid rx.temp /= ${BASE} rx.int',
    'scoreboard players operation $bit rx.temp = $uid rx.temp',
    'execute store result storage rx:global playerdb.players[-1].bits.b{bit} byte 1 run scoreboard players operation $bit rx.temp %= ${base} rx.int',  # noqa: E501
)

debug_line = 'tellraw @s[tag=rx.PDBDebug] [{"text":"", "color":"gold"}, {"text":"bit^: "}, {"score":{"name":"$bit", "objective":"rx.temp"}}]'  # noqa: E501

out = [COMMENT]
for i in range(0, int(math.log(MAX_INT, BASE)) + 2):
    if i != 0:
        out.append(lines[0])
    out.append(lines[1])
    out.append(lines[2].format(bit=i, base=BASE))
    if DEBUG:
        out.append(debug_line.replace('^', str(i)))
    out.append('\n')

with open(f'uid_to_bits.mcfunction', 'w') as file:
    file.write('\n'.join(out))
