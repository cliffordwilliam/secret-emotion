# This is an autoload class (InputConstants)
extends Node
# Validates GUI against my const (input names)

const LEFT_INPUT_NAME: StringName = "left"
const RIGHT_INPUT_NAME: StringName = "right"
const SHIFT_INPUT_NAME: StringName = "shift"
const DOWN_INPUT_NAME: StringName = "down"
const JUMP_INPUT_NAME: StringName = "jump"
const UP_INPUT_NAME: StringName = "up"
const ALL_ACTIONS: Array[StringName] = [
	LEFT_INPUT_NAME,
	RIGHT_INPUT_NAME,
	SHIFT_INPUT_NAME,
	DOWN_INPUT_NAME,
	JUMP_INPUT_NAME,
	UP_INPUT_NAME,
]


func _ready() -> void:
	_validate_gui()


func _validate_gui() -> void:
	for action in ALL_ACTIONS:
		if not InputMap.has_action(action):
			push_error("❌ GUI 'Input Map' missing: %s" % action)
			get_tree().quit(1)

	print("✅ GUI 'Input Map' valid.")
