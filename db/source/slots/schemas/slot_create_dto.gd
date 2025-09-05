class_name SlotCreateDTO
extends RefCounted

# Props
var label: String


# Validation
func _init(data: Dictionary) -> void:
	if not data.has("label"):
		push_error("Missing required field: label")
		assert(false)
	label = str(data["label"]).strip_edges()
	if label == "":
		push_error("Slot label cannot be empty")
		assert(false)


# Dict version
func to_dict() -> Dictionary:
	return {"label": label}
