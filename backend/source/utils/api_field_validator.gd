class_name ApiFieldValidator
extends Node
# TODO: Can activate global error boundary


static func require_key(dict: Dictionary, key: String) -> void:
	if not dict.has(key):
		push_error("Missing required field: %s" % key)
		assert(false)


static func require_string(dict: Dictionary, key: String, regex_pattern: String = "") -> String:
	require_key(dict, key)
	var value: String = str(dict[key]).strip_edges()
	if value == "":
		push_error("%s cannot be empty" % key)
		assert(false)
	if regex_pattern != "":
		var regex: RegEx = RegEx.new()
		if regex.compile(regex_pattern) == OK:
			if regex.search(value):
				push_error("%s has invalid format: %s" % [key, value])
				assert(false)
	return value


static func require_float(dict: Dictionary, key: String, positive_only: bool = false) -> float:
	require_key(dict, key)
	var value: float = dict[key]
	if not ApiTypeValidator.is_float(value) and not ApiTypeValidator.is_int(value):
		push_error("%s must be a float" % key)
		assert(false)
	value = float(value)
	if positive_only and value < 0.0:
		push_error("%s must be positive" % key)
		assert(false)
	return value


static func require_int(dict: Dictionary, key: String, positive_only: bool = false) -> int:
	require_key(dict, key)
	var value: int = dict[key]
	if not ApiTypeValidator.is_int(value):
		push_error("%s must be an int" % key)
		assert(false)
	value = int(value)
	if positive_only and value < 0:
		push_error("%s must be positive" % key)
		assert(false)
	return value


static func require_bool(dict: Dictionary, key: String) -> bool:
	require_key(dict, key)
	return int(dict[key]) != 0
