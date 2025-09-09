class_name ApiRoomCreateDto
extends RefCounted

var room_name: String
var scene_file_path: String
var active_status: bool = false


func _init(data: Dictionary) -> void:
	room_name = ApiFieldValidator.require_string(data, "room_name")
	scene_file_path = ApiFieldValidator.require_string(data, "scene_file_path")
	active_status = ApiFieldValidator.require_bool(data, "active_status")


func to_dict() -> Dictionary:
	return {
		"room_name": room_name,
		"scene_file_path": scene_file_path,
		"active_status": 1 if active_status else 0
	}
