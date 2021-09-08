from beet import FunctionTag, Function, Context
import yaml

body = "execute if score rx.pdb.__verstr__ load.status matches 1 run function ../api_logic/{api}"

api_calls = [
    "get",
    "get_self",
    "save",
    "save_self",
    "add_entry",
    "select",
]


def beet_default(ctx: Context):
    major = ctx.meta["version"].major
    for call in api_calls:
        tag = FunctionTag({"values": [ctx.generate.path(f'version_check/{call}')]})
        
        with ctx.override(generate_prefix=f"api/v{major}"):
            ctx.generate(call, tag)

        ctx.generate(f"version_check/{call}", Function(body.format(api=call)))
