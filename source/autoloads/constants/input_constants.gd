# This is an autoload class (InputConstants)
extends Node
# Validates GUI against my const (input map)

const LEFT_INPUT: StringName = "left"
const RIGHT_INPUT: StringName = "right"
const SHIFT_INPUT: StringName = "shift"
const DOWN_INPUT: StringName = "down"
const JUMP_INPUT: StringName = "jump"
const ALL_ACTIONS: Array[StringName] = [
	LEFT_INPUT,
	RIGHT_INPUT,
	SHIFT_INPUT,
	DOWN_INPUT,
	JUMP_INPUT,
]


func _ready():
	_validate_gui()


func _validate_gui():
	for action in ALL_ACTIONS:
		if not InputMap.has_action(action):
			push_error("❌ GUI 'Input Map' missing: %s" % action)
			get_tree().quit(1)

	print("✅ GUI 'Input Map' valid.")
