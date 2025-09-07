class_name ApiSlotCreateDto
extends RefCounted

# Schema props
var slot_name: String


# Will only instance when shape is valid
func _init(data: Dictionary) -> void:
	if not data.has("slot_name"):
		push_error("Missing required field: slot_name")
		assert(false)
	slot_name = str(data["slot_name"]).strip_edges()
	if slot_name == "":
		push_error("Slot slot_name cannot be empty")
		assert(false)


# Transform to dict for repository
func to_dict() -> Dictionary:
	return {"slot_name": slot_name}
