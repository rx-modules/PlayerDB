"""Plugin that installs a Jinja extension for debug statements."""


__all__ = [
    "DebugStatement",
]


from typing import Any, List

from jinja2.nodes import ExprStmt, Node, Expr, Const, Output, TemplateData

from beet import Context, FunctionTag, JinjaExtension

from pydantic import BaseModel

import json


def beet_default(ctx: Context):
    ctx.template.env.add_extension(OutStatement)


class OutOptions(BaseModel):
    command: str = 'tellraw @a '
    stringify: bool = False


class OutStatement(JinjaExtension):
    """A Jinja extension that allows you to output scores and storage easier."""

    tags = {"out"}

    def parse(self, parser: Any) -> Node:
        lineno = next(parser.stream).lineno
        mode = next(parser.stream)
        if not mode.test_any("name:score", "name:storage", "name:entity"):
            return parser.fail("Failed to provide score, storage or entity")
            
        target, name = parser.parse_tuple().items

        args = [TemplateData(mode.value), name, target, TemplateData(lineno)]

        return Output(
            [self.call_method("_out_handler", args, lineno=lineno)],
            lineno=lineno,
        )

    def _out_handler(self, mode, identifier, target, lineno) -> str:
        if self.ctx.meta["render_group"] != "functions":
            raise TypeError("Out statements can only be used inside functions.")

        kwargs = {
            'mode': f'{mode!r}',
            'identifier': f'{identifier!r}',
            'target': f'{target!r}',
            'lineno': f'{lineno!r}'
        }

        if mode == "score":
            accessor = {
                "score": {"name": "{{identifier}}", "objective": "{{target}}"}
            }
        elif mode == "storage":
            accessor = {"storage": "{{target}}", "nbt": "{{identifier}}"}
        elif mode == "entity":
            accessor = {"entity": "{{target}}", "nbt": "{{identifier}}"}
        elif mode == "block":
            accessor = {"block": "{{target}}", "nbt": "{{identifier}}"}

        hover = {
            "text": "",
            "hoverEvent": {
                "action": "show_text",
                "contents": [
                    "",
                    {"text": "Type: {{mode | title}}\n", "color": "gray"},
                    {"text": "Filename: {{ctx.meta.render_path}}\n", "color": "gray"},
                    {"text": "Lineno: {{lineno}}\n", "color": "gray"},
                    {"text": "\n", "color": "gray"}
                ]
            }
        }

        # func = self.ctx.data[self.ctx.meta['render_path']]
        # tellraw_line = func.lines[lineno]
        # surrounding = [line for line in func.lines if line]
        
        # if (fake_lineno := surrounding.index(tellraw_line)):
        #     for i in range(lineno-1, lineno+2):
        #         if 0 < i < len(surrounding):
        #             hover['hoverEvent']['contents'].append(surrounding[i])

        payload = [
            hover,
            {"text": "[{{ctx.project_name}}]: ", "color": "gray"},
            {"text": "<{{identifier}} ", "color": "gold", "extra":[accessor, " >"]},
        ]

        rendered = self.ctx.template.render_json(payload, **kwargs)

        return f"tellraw @a[tag=rx.admin] {json.dumps(rendered)}\n"
