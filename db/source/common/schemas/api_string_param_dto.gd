class_name ApiStringParamDto
extends RefCounted
## [code]asd/{id}[/code]:[br]
## - required.[br]
## - must be string.[br]
## - cannot be empty string.[br]

# Schema props
var string_param: String


# Will only instance when shape is valid
# TODO: Can activate global error boundary
func _init(given_string_param: String, caller_origin: String) -> void:
	# Its string?
	if not ApiTypeValidator.is_string(given_string_param):
		pass
	# Its not an empty string?
	string_param = str(given_string_param).strip_edges()
	if string_param == "":
		push_error("'%s': string_param cannot be empty" % caller_origin)
		assert(false)
