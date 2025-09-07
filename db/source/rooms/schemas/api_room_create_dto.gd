class_name ApiRoomCreateDto
extends RefCounted

# Schema props
var slot_id: int
var room_name: String
var current_room: bool = false


# Will only instance when shape is valid
func _init(data: Dictionary) -> void:
	slot_id = ApiFieldValidator.require_int(data, "slot_id")
	room_name = ApiFieldValidator.require_string(data, "room_name")
	if data.has("current_room"):
		current_room = ApiFieldValidator.require_bool(data, "current_room")


# Transform to dict for repository input
func to_dict() -> Dictionary:
	return {"slot_id": slot_id, "room_name": room_name, "current_room": 1 if current_room else 0}
