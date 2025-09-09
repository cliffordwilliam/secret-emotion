class_name ApiIntParamDto
extends RefCounted

var int_param: int


func _init(given_int_param: int) -> void:
	if not ApiTypeValidator.is_int(given_int_param):
		push_error("int_param must be an integer")
		assert(false)

	int_param = int(given_int_param)
