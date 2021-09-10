"""Plugin for rx-module base"""


import json
import math
from pathlib import Path

import yaml
from beet import Context, Function, FunctionTag
from beet.core.file import File, TextFile
from beet.library.data_pack import Advancement


def beet_default(ctx: Context):
    ctx.data["global:root"] = Advancement(
        {
            "display": {
                "title": "Installed Datapacks",
                "description": "",
                "icon": {"item": "minecraft:knowledge_book"},
                "background": "minecraft:textures/block/gray_concrete.png",
                "show_toast": False,
                "announce_to_chat": False,
            },
            "criteria": {"trigger": {"trigger": "minecraft:tick"}},
        }
    )

    ctx.data["global:rx97"] = Advancement(
        {
            "display": {
                "title": "rx97",
                "description": "I guess I make datapacks",
                "icon": {
                    "item": "minecraft:player_head",
                    "nbt": "{SkullOwner: 'rx97'}",
                },
                "show_toast": False,
                "announce_to_chat": False,
            },
            "parent": "global:root",
            "criteria": {"trigger": {"trigger": "minecraft:tick"}},
        }
    )

    item = ctx.meta.get("advancements", {}).get("item", "minecraft:stone")
    ctx.data[f"{ctx.project_id}:global"] = Advancement(
        {
            "display": {
                "title": ctx.meta["globals"]["pretty_name"],
                "description": ctx.project_description,
                "icon": {"item": item},
                "announce_to_chat": False,
                "show_toast": False,
            },
            "parent": "global:rx",
            "criteria": {"trigger": {"trigger": "minecraft:tick"}},
        }
    )