extends Node

const LEFT_INPUT := "left"
const RIGHT_INPUT := "right"
const ALL = [
	LEFT_INPUT,
	RIGHT_INPUT,
]


func _ready():
	_validate_inputs()


func _validate_inputs():
	for action in ALL:
		if not InputMap.has_action(action):
			push_error("❌ Input action missing from InputMap: %s" % action)

	# Cannot check if some GUI input maps are not in ALL since it has defaults like ui_up, ...

	print("✅ All const input names are in GUI.")
