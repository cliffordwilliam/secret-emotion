class_name ApiRoomContextCreateDto
extends RefCounted

# Schema props
var room_name: String
var scene_file_path: String
var current_room: bool = false


func _init(data: Dictionary) -> void:
	room_name = ApiFieldValidator.require_string(data, "room_name")
	scene_file_path = ApiFieldValidator.require_string(data, "scene_file_path")
	if data.has("current_room"):
		current_room = ApiFieldValidator.require_bool(data, "current_room")


# Transform to dict for repository input
func to_dict() -> Dictionary:
	return {
		"room_name": room_name,
		"scene_file_path": scene_file_path,
		"current_room": 1 if current_room else 0
	}
