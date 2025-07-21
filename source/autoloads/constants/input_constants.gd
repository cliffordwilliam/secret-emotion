# This is an autoload class (InputConstants)
extends Node
# Validates GUI against my const (input map)

const LEFT_INPUT: StringName = "left"
const RIGHT_INPUT: StringName = "right"
const ALL_ACTIONS: Array[StringName] = [
	LEFT_INPUT,
	RIGHT_INPUT,
]


func _ready():
	_validate_gui_input_map()


func _validate_gui_input_map():
	for action in ALL_ACTIONS:
		if not InputMap.has_action(action):
			push_error("❌ GUI input map missing: %s" % action)
			get_tree().quit(1)

	print("✅ GUI input maps are valid.")
