comment = (
    '# By: shraavan97\n'
    '# 20 Nov 2019\n\n'
)

lines = ['scoreboard players operation $bit rx.temp = $uid rx.temp',
'scoreboard players operation $bit rx.temp %= $3 rx.int',
'execute if score $bit rx.temp matches 0 run data modify storage rx:temp playerdb.filtered^ append from storage rx:temp playerdb.filtered&[{bit^:0b}]',  # noqa
'execute if score $bit rx.temp matches 1 run data modify storage rx:temp playerdb.filtered^ append from storage rx:temp playerdb.filtered&[{bit^:1b}]',  # noqa
'execute if score $bit rx.temp matches 2 run data modify storage rx:temp playerdb.filtered^ append from storage rx:temp playerdb.filtered&[{bit^:2b}]',  # noqa
'scoreboard players operation $uid rx.temp /= $3 rx.int',
'execute store result score $size rx.temp if data storage rx:temp playerdb.filtered^[]',
'execute if score $size rx.temp matches 0..1 run data modify storage rx:output playerdb.player set from storage rx:temp playerdb.filtered^[0]',  # noqa
'execute if score $size rx.temp matches 2.. run function rx:playerdb/_fast_get/bit!']

for i in range(0, 20):
    out = [comment]

    for line in lines:
        if i == 19 and line.startswith('execute if score $size rx.temp matches 2..'):
            out.append('execute if score $size rx.temp matches 2.. run tellraw @a {"text": "ERROR, ERROR", "color":"red"}')  # noqa
            continue
        line = line.replace('!', str(i+1))
        line = line.replace('^', str(i))

        if i - 1 < 0:
            line = line.replace('&', '')
        else:
            line = line.replace('&', str(i-1))

        out.append(line)

    with open(f'bit{i}.mcfunction', 'w') as file:
        file.write('\n'.join(out))
