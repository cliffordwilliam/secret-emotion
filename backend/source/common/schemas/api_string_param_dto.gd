class_name ApiStringParamDto
extends RefCounted

var string_param: String


func _init(given_string_param: String) -> void:
	if not ApiTypeValidator.is_string(given_string_param):
		push_error("string_param must be a string")
		assert(false)

	string_param = str(given_string_param).strip_edges()
	if string_param == "":
		push_error("string_param cannot be empty")
		assert(false)
