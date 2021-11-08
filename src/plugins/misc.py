"""Plugin for rx-module base"""

import math
from collections import namedtuple
from itertools import chain
from typing import cast

from beet import Context
from beet.core.utils import JsonDict
from colour import Color

SemVer = namedtuple("version", ("major", "minor", "patch"))


def function_headers(ctx: Context):
    for name, func in ctx.data.functions.items():
        func.lines.insert(0, f"# source: {name}")


def pretty_name(ctx: Context, color1: str, color2: str) -> dict:
    name = ctx.project_name

    c1, c2 = Color(color1), Color(color2)

    first_half = c1.range_to(c2, math.floor(len(name) / 2))
    second_half = c2.range_to(c1, math.ceil(len(name) / 2))

    return {
        "text": "",
        "extra": [
            {"text": letter, "color": color.hex_l}
            for letter, color in zip(name, chain(first_half, second_half))
        ],
    }


def globals(ctx: Context):
    config = ctx.meta.get("globals", cast(JsonDict, {}))

    parts = ctx.project_id.split(".")
    ctx.meta["shorthand"] = parts[1] if len(parts) > 1 else parts[0]

    ctx.meta["version"] = SemVer(*ctx.project_version.split("."))
    ctx.meta["verstr"] = ".".join(ctx.meta["version"])

    if "colors" in config:
        config["pretty_name"] = pretty_name(
            ctx, config["colors"][0], config["colors"][1]
        )


def gen_namespace(ctx: Context):
    version = ctx.meta["version"]
    ctx.meta["generate_namespace"] = "rx.playerdb"
    ctx.meta["generate_prefix"] = f"impl/v{'.'.join(version)}"
