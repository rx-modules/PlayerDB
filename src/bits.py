from beet import Function, Context
import math

BASE = 64
BRANCHES = 8
MAX_INT = 2 ** 31 - 1

ITERATIONS = math.log(MAX_INT, BASE) + 1


TREE = "execute if score $bit rx.temp matches {low}..{high} run function select/tree/bit{num}/{low}_{high}"  # noqa: E501

LEAF = "execute if score $bit rx.temp matches @ if data storage rx:global playerdb.players[{selected:1b, bits:{b%:@b}}] store result score $size rx.temp run data modify storage rx:global playerdb.players[{selected:1b, bits:{b%:@b}}].bits.select set value 1b"  # noqa: E501


def beet_default(ctx: Context):
    for i in range(int(ITERATIONS) + 1):
        gen_bit(ctx, i)
        gen_tree(ctx, i, 0, BASE)


def gen_bit(ctx: Context, bit_num: int):
    bit = (
        "data modify storage rx:global playerdb.players[].bits.select set value 0b\n"
        "scoreboard players operation $bit rx.temp = $uid rx.temp\n"
        f"scoreboard players operation $bit rx.temp %= ${BASE} rx.int\n"
        "scoreboard players set $size rx.temp 0\n"
        f"function select/tree/bit{bit_num}/0_{BASE-1}\n"
        f"scoreboard players operation $uid rx.temp /= ${BASE} rx.int\n"
        "execute if data storage rx:global playerdb.players[{bits:{select:0b}}] run data modify storage rx:global playerdb.players[{bits:{select:0b}}].selected set value 0b\n"  # noqa
        f"execute if score $size rx.temp matches 2.. run function select/tree/bit{bit_num+1}\n"  # noqa: E501
    )
    ctx.generate(f"select/tree/bit{bit_num}", Function(bit))


def gen_tree(ctx: Context, bit_num: int, low: int, high: int):
    change = (high - low) // BRANCHES

    low_values = [low + change * i for i in range(BRANCHES)]
    high_values = [(low + change * (i + 1)) for i in range(BRANCHES)]

    values = list(zip(low_values, high_values))

    if low + BRANCHES < high:
        tree = tuple(
            TREE.format(low=value[0], high=value[1] - 1, num=bit_num)
            for value in values
        )

        ctx.generate(f"select/tree/bit{bit_num}/{low}_{high-1}", Function(tree))

        for value in values:
            gen_tree(ctx, bit_num, value[0], value[1])

    else:
        leaf = tuple(
            LEAF.replace("@", str(low + i)).replace("%", str(bit_num))
            for i in range(BRANCHES)
        )
        ctx.generate(f"select/tree/bit{bit_num}/{low}_{low+BRANCHES-1}", Function(leaf))
