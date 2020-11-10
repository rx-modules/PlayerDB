from pathlib import Path
import math


COMMENT = (
    '# By: rx97\n'
)

BASE = 64
MAX_INT = 2**31-1

ITERATIONS = math.log(MAX_INT, BASE) + 1


TREE = 'execute if score $bit rx.temp matches {low}..{high} run function rx.playerdb:impl/uuid/select/bit{num}/{low}_{high}'  # noqa: E501

LEAF = (
    'execute if score $bit rx.temp matches @ if data storage rx:global playerdb.uuid[{bits:{b%:@b}}] run data modify storage rx:global playerdb.uuid[{bits:{b%:@b}}].bits.select set value 1b'  # noqa: E501
)


def make_file(path, content):
    if isinstance(content, list) or isinstance(content, tuple):
        content = '\n'.join(content)

    path.parent.mkdir(parents=True, exist_ok=True)

    with path.open('w') as file:
        file.write(COMMENT + content)


def gen_bit(bit_num):
    bit = (
        'data modify storage rx:global playerdb.uuid[].bits.select set value 0b\n'
        'scoreboard players operation $bit rx.temp = $uid rx.temp\n'
        f'scoreboard players operation $bit rx.temp %= ${BASE} rx.int\n'
        f'function rx.playerdb:impl/uuid/select/bit{bit_num}/0_{BASE-1}\n'
        f'scoreboard players operation $uid rx.temp /= ${BASE} rx.int\n'
        'data modify storage rx:global playerdb.uuid[{bits:{select:0b}}].selected set value 0b\n'
        'execute store result score $size rx.temp if data storage rx:global playerdb.uuid[{selected:1b}]\n'  # noqa: E501
        f'execute if score $size rx.temp matches 2.. run function rx.playerdb:impl/uuid/select/bit{bit_num+1}\n'  # noqa: E501
    )
    fname = Path(f'bit{bit_num}.mcfunction')
    make_file(fname, bit)


def gen_tree(bit_num, low, high):
    change = (high - low) // 4
    if low + 4 < high:
        tree = (
            TREE.format(low=low, high=low+change-1, num=bit_num),
            TREE.format(low=low+change, high=low+change*2-1, num=bit_num),
            TREE.format(low=low+change*2, high=low+change*3-1, num=bit_num),
            TREE.format(low=low+change*3, high=high-1, num=bit_num),
        )
        make_file(Path(f'bit{bit_num}/{low}_{high-1}.mcfunction'), tree)
        gen_tree(bit_num, low, change)
        gen_tree(bit_num, low+change, low+change*2)
        gen_tree(bit_num, low+change*2, low+change*3)
        gen_tree(bit_num, low+change*3, high)

    else:
        leaf = tuple(
            LEAF.replace('@', str(low+i)).replace('%', str(bit_num))
            for i in range(4)
        )
        make_file(Path(f'bit{bit_num}/{low}_{low+3}.mcfunction'), leaf)


def main():
    for i in range(int(ITERATIONS)+1):
        gen_bit(i)
        gen_tree(i, 0, BASE)


if __name__ == '__main__':
    main()
