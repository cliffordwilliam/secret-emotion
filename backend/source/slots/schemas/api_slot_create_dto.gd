class_name ApiSlotCreateDto
extends RefCounted

# Schema props
var slot_name: String


# Will only instance when shape is valid
func _init(data: Dictionary) -> void:
	slot_name = ApiFieldValidator.require_string(data, "slot_name")


# Transform to dict for repository input
func to_dict() -> Dictionary:
	return {"slot_name": slot_name}
