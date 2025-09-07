class_name ApiRoomResponseDto
extends ApiBaseResponseDto

# Schema props
var room_id: int
var slot_id: int
var room_name: String
var current_room: bool
var date_created: String
var date_modified: String


# Pass empty dict to turn this into error version, can set optional error message too
func _init(db_dict_response: Dictionary = {}, given_error_message: String = "") -> void:
	super._init(db_dict_response, given_error_message)
	# Quit early if this is error version, just need the parent given_error_message
	if error:
		return
	# If normal version then validate first then fill all my props with it
	room_id = ApiFieldValidator.require_int(db_dict_response, "room_id", true)
	slot_id = ApiFieldValidator.require_int(db_dict_response, "slot_id")
	room_name = ApiFieldValidator.require_string(db_dict_response, "room_name")
	current_room = ApiFieldValidator.require_bool(db_dict_response, "current_room")
	date_created = ApiFieldValidator.require_string(
		db_dict_response, "date_created", ApiRegexConstants.ISO8601_REGEX
	)
	date_modified = ApiFieldValidator.require_string(
		db_dict_response, "date_modified", ApiRegexConstants.ISO8601_REGEX
	)
