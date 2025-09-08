class_name ApiBaseResponseDto
extends RefCounted
# This exists because response can be OK and BAD

# To tell consumer if this is an error BAD version
var error: bool = false
var error_message: String = ""


# To make error BAD version, just pass empty dict AND optional error message
func _init(data: Dictionary = {}, given_error_message: String = "") -> void:
	if data.is_empty():
		error = true
		error_message = given_error_message
