class_name ApiTypeValidator
extends Node
# Holds func to check types, returns bool


static func is_int(value: Variant) -> bool:
	if typeof(value) != TYPE_INT:
		return false
	return true


static func is_string(value: Variant) -> bool:
	if typeof(value) != TYPE_STRING:
		return false
	return true


static func is_float(value: Variant) -> bool:
	if typeof(value) != TYPE_FLOAT:
		return false
	return true
