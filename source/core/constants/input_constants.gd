extends Node
# Validates GUI against const (input map)

const LEFT_INPUT: String = "left"
const RIGHT_INPUT: String = "right"
const ALL_ACTIONS: Array[String] = [
	LEFT_INPUT,
	RIGHT_INPUT,
]


func _ready():
	_validate_gui_input_map()


func _validate_gui_input_map():
	for action in ALL_ACTIONS:
		if not InputMap.has_action(action):
			push_error("❌ GUI input map missing this action: %s" % action)
			get_tree().quit(1)

	print("✅ GUI input map is valid.")
