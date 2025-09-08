class_name ApiChestContextEditDto
extends RefCounted

var chest_name: String
var chest_state: String = ""


func _init(data: Dictionary) -> void:
	chest_name = ApiFieldValidator.require_string(data, "chest_name")

	if data.has("chest_state") and str(data["chest_state"]).strip_edges() != "":
		chest_state = ApiFieldValidator.require_string(data, "chest_state")


func to_dict() -> Dictionary:
	var dict: Dictionary = {
		"chest_name": chest_name,
	}
	if chest_state != "":
		dict["current_state"] = chest_state
	return dict
