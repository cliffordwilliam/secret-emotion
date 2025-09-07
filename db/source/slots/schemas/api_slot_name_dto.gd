class_name ApiSlotNameDto
extends RefCounted

# Schema props
var slot_name: String


# Will only instance when shape is valid
func _init(given_slot_name: String) -> void:
	slot_name = str(given_slot_name).strip_edges()
	if slot_name == "":
		push_error("Slot slot_name cannot be empty")
		assert(false)


# Transform to dict for repository
func to_dict() -> Dictionary:
	return {"slot_name": slot_name}
