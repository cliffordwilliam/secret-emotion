class_name ApiSlotCreateDto
extends RefCounted

var slot_name: String


func _init(data: Dictionary) -> void:
	slot_name = ApiFieldValidator.require_string(data, "slot_name")
