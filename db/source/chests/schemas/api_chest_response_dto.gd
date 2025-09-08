class_name ApiChestResponseDto
extends ApiBaseResponseDto

var chest_id: int
var room_id: int
var chest_name: String
var chest_state: String
var date_created: String
var date_modified: String


func _init(db_dict_response: Dictionary = {}, given_error_message: String = "") -> void:
	super._init(db_dict_response, given_error_message)
	if error:
		return

	chest_id = ApiFieldValidator.require_int(db_dict_response, "chest_id", true)
	room_id = ApiFieldValidator.require_int(db_dict_response, "room_id", true)
	chest_name = ApiFieldValidator.require_string(db_dict_response, "chest_name")
	chest_state = ApiFieldValidator.require_string(db_dict_response, "current_state")
	date_created = ApiFieldValidator.require_string(
		db_dict_response, "date_created", ApiRegexConstants.ISO8601_REGEX
	)
	date_modified = ApiFieldValidator.require_string(
		db_dict_response, "date_modified", ApiRegexConstants.ISO8601_REGEX
	)
