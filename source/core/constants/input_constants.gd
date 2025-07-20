extends Node

const LEFT_INPUT: String = "left"
const RIGHT_INPUT: String = "right"
const ALL_ACTIONS: Array[String] = [
	LEFT_INPUT,
	RIGHT_INPUT,
]


func _ready():
	_validate_inputs()


func _validate_inputs():
	for action in ALL_ACTIONS:
		if not InputMap.has_action(action):
			push_error("❌ Input action missing from InputMap: %s" % action)
			get_tree().quit(1)

	# Can't check if GUI input maps are not in ALL_ACTIONS since it has defaults (ui_up, ...)

	print("✅ All const input names are in GUI.")
