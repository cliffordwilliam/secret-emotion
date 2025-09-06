class_name SaveMenuBaseModeStrategy
extends RefCounted
# This is an owner extension

var owner: SaveMenu


func _init(_owner: SaveMenu) -> void:
	owner = _owner


func can_handle(_action: int) -> bool:
	return false


func on_ready_logic() -> void:
	pass


func on_button_pressed_logic(_slot: WorldState.SaveSlot) -> void:
	pass
