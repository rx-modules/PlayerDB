"""Plugin that installs a Jinja extension for debug statements."""


__all__ = [
    "OutStatement",
]


from typing import Any, List

from jinja2.nodes import ExprStmt, Node, Expr, Const, Output, TemplateData

from beet import Context, FunctionTag, JinjaExtension

from pydantic import BaseModel
from functools import cached_property

import json


def beet_default(ctx: Context):
    ctx.template.env.add_extension(OutStatement)


class OutOptions(BaseModel):
    command: str = "tellraw @a {payload}"
    payload: List[dict] = [
        {
            "text": "",
            "hoverEvent": {
                "action": "show_text",
                "contents": [
                    "",
                    {"text": "Type: {{ mode | title }}\n", "color": "gray"},
                    {"text": "Path: {{ render_path }}\n", "color": "gray"},
                    {"text": "Lineno: {{ lineno }}", "color": "gray"},
                ],
            },
        },
        {"text": "[{{ project_name }}]: ", "color": "gray"},
        {
            "text": "< {{ identifier }} ",
            "color": "gold",
            "extra": ["{{ accessor }}", " >"],
        },
    ]
    stringify: bool = False


class OutStatement(JinjaExtension):
    """A Jinja extension that allows you to output scores and storage easier."""

    tags = {"out"}

    @cached_property
    def opts(self) -> OutOptions:
        return self.ctx.validate("out", OutOptions)

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

    def _out_handler(self, mode: str, identifier: str, target: str, lineno: int) -> str:
        if self.ctx.meta["render_group"] != "functions":
            raise TypeError("Out statements can only be used inside functions.")

        kwargs = {
            "mode": mode,
            "identifier": identifier,
            "target": target,
            "lineno": lineno,
        }

        accessor = None
        if mode == "score":
            accessor = self.ctx.template.render_json(
                {"score": {"name": "{{identifier}}", "objective": "{{target}}"}},
                **kwargs,
            )
        elif mode == "storage":
            accessor = self.ctx.template.render_json(
                {"storage": "{{target}}", "nbt": "{{identifier}}"}, **kwargs
            )
        elif mode == "entity":
            accessor = self.ctx.template.render_json(
                {"entity": "{{target}}", "nbt": "{{identifier}}"}, **kwargs
            )
        elif mode == "block":
            accessor = self.ctx.template.render_json(
                {"block": "{{target}}", "nbt": "{{identifier}}"}, **kwargs
            )

        if not accessor:
            raise Exception

        rendered = self.ctx.template.render_string(
            json.dumps(self.opts.payload),
            accessor='",' + json.dumps(accessor) + ',"',
            **kwargs,
        )
        # rendered = self.ctx.template.render_json(self.opts.payload, **kwargs)

        return self.opts.command.format(payload=rendered) + '\n'
