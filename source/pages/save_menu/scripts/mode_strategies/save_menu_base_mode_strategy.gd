class_name SaveMenuBaseModeStrategy
extends RefCounted
# TODO: Delete this, we want 2 seperated page, save and load
# TODO: But is that redundant? Yeah but at least its flexible and UI is messy in nature anyways

var owner: SaveMenu


func _init(_owner: SaveMenu) -> void:
	owner = _owner


func can_handle(_action: int) -> bool:
	return false


func on_ready_logic() -> void:
	pass


func on_button_pressed_logic(_slot: WorldState.SaveSlot) -> void:
	pass
