from beet import FunctionTag, Function
import yaml

location = 'rx.playerdb:api/v{major}/{api}'
target = 'rx.playerdb:impl/check_api/{api}'

version_check = 'rx.playerdb:impl/version_check/{api}'
body = 'execute if score rx.pdb.__ver__ load.status matches 1 run function ../api_logic/{api}'

api_calls = [
	'get',
	'get_self',
	'save',
	'save_self',
	'add_entry',
	'select',
]


def beet_default(ctx: Context):
	for call in api_calls:
		loc = location.format(
			major=ctx.meta['version'].major,
			api=call
		)
		ctx.data[loc] = FunctionTag(
			{"values": [target.format(api=call)]}
		)

		loc = version_check.format(api=call)
		ctx.data[loc] = Function(body.format(api=call))

