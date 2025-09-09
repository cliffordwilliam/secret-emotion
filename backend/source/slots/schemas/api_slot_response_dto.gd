class_name ApiSlotResponseDto
extends ApiBaseResponseDto

var slot_id: int
var slot_name: String
var active_status: bool
var date_created: String
var date_modified: String


func _init(db_dict_response: Dictionary = {}, given_error_message: String = "") -> void:
	super._init(db_dict_response, given_error_message)

	if error:
		return

	slot_id = ApiFieldValidator.require_int(db_dict_response, "slot_id", true)
	slot_name = ApiFieldValidator.require_string(db_dict_response, "slot_name")
	active_status = ApiFieldValidator.require_bool(db_dict_response, "active_status")
	date_created = ApiFieldValidator.require_string(
		db_dict_response, "date_created", ApiRegexConstants.ISO8601_REGEX
	)
	date_modified = ApiFieldValidator.require_string(
		db_dict_response, "date_modified", ApiRegexConstants.ISO8601_REGEX
	)


static func err(message: String) -> ApiSlotResponseDto:
	return ApiSlotResponseDto.new({}, message)
