class_name ApiChestContextCreateDto
extends RefCounted

# Schema props
var chest_name: String
var chest_state: String


func _init(data: Dictionary) -> void:
	chest_name = ApiFieldValidator.require_string(data, "chest_name")
	chest_state = ApiFieldValidator.require_string(data, "chest_state")


func to_dict() -> Dictionary:
	return {
		"chest_name": chest_name,
		"chest_state": chest_state,
	}
