class_name ApiPlayerEditDto
extends RefCounted

# Schema props
var player_pos_x: float
var player_pos_y: float
var flip_h: bool


func _init(data: Dictionary) -> void:
	player_pos_x = ApiFieldValidator.require_float(data, "player_pos_x")
	player_pos_y = ApiFieldValidator.require_float(data, "player_pos_y")
	flip_h = ApiFieldValidator.require_bool(data, "flip_h")


func to_dict() -> Dictionary:
	return {
		"player_pos_x": player_pos_x,
		"player_pos_y": player_pos_y,
		"flip_h": 1 if flip_h else 0,
	}
