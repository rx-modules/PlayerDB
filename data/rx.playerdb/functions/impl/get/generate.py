from datetime import datetime
from pathlib import Path
import math


COMMENT = (
    '# By: rx97\n'
    f"# Generated on: {datetime.now().strftime(r'%d %b %y')}\n\n"
)

BASE = 4
RANGE = 64
MAX_INT = 2**31-1

ITERATIONS = math.log(MAX_INT, RANGE)

LINE = 'execute if score $bit rx.temp matches {low}..{high} run function rx.playerdb:impl/get/bit{i}/{low}_{high}'  # noqa: E501

LEAF = (
    'execute if score $bit rx.temp matches {num} run data modify rx:temp playerdb.filtered{bit1} set from storage rx:temp playerdb.filtered{bit}[{s}]'  # noqa: E501
)


BIT = (
    'scoreboard players operation $bit rx.temp = $uid rx.temp\n'
    f'scoreboard players operation $bit rx.temp %= ${RANGE} rx.int\n'
    f'scoreboard players operation $uid rx.temp /= ${RANGE} rx.int\n'
    'function rx.playerdb:impl/get/bit{bit}/0_' + str(RANGE-1) + '\n'
    'execute store result score $size rx.temp if data storage rx:temp playerdb.filtered{bit}[]\n'
    'execute if score $size rx.temp matches 0..1 run data modify storage rx:io playerdb.player set from storage rx:temp playerdb.filtered{bit}[0]\n'  # noqa: E501
    'execute if score $size rx.temp matches 2.. run function rx.playerdb:impl/get/bit{bit1}\n'  # noqa: E501
)


def make_file(path, input):
    if isinstance(input, list):
        input = '\n'.join(input)

    with path.open('w') as file:
        file.write(COMMENT + input)


def gen_tree(nums, bit):
    return [
        LINE.format(low=nums[i], high=nums[i+1]-1, i=bit)
        for i in range(0, BASE)
    ]


def gen_leaf(low, high, bit):
    return [
        LEAF.format(num=i, bit1=bit+1, bit=bit, s='{' + f'bit{bit}:{i}b' + '}')
        for i in range(low, high)
    ]


def gen_bits(low, high, bit):
    print(f'bit{bit}: [{low}, {high}]')

    if high - low > 4:
        nums = tuple(range(low, high+1, (high-low)//4))
        print(f'{nums}\n')
        lines = gen_tree(nums, bit)
        fldr = Path(f'bit{bit}')
        fldr.mkdir(parents=True, exist_ok=True)
        make_file(fldr / f'{low}_{high-1}.mcfunction', lines)

        for i in range(0, BASE):
            gen_bits(nums[i], nums[i+1], bit)

    else:
        lines = gen_leaf(low, high, bit)
        fldr = Path(f'bit{bit}')
        fldr.mkdir(parents=True, exist_ok=True)
        make_file(fldr / f'{low}_{high-1}.mcfunction', lines)


def main():
    for i in range(int(ITERATIONS)):
        make_file(Path(f'bit{i}.mcfunction'), BIT.format(bit=i, bit1=i+1))
        gen_bits(0, RANGE, i)


if __name__ == '__main__':
    main()
