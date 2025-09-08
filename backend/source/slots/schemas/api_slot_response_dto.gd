class_name ApiSlotResponseDto
extends ApiBaseResponseDto

# Schema props
var slot_id: int
var slot_name: String
var active_status: bool
var last_played_at: String
var play_time_seconds: int
var date_created: String
var date_modified: String


# Pass empty dict to turn this into error version, can set optional error message too
func _init(db_dict_response: Dictionary = {}, given_error_message: String = "") -> void:
	super._init(db_dict_response, given_error_message)
	# Quit early if this is error version, just need the parent given_error_message
	if error:
		return
	# If normal version then validate first then fill all my props with it
	slot_id = ApiFieldValidator.require_int(db_dict_response, "slot_id", true)
	slot_name = ApiFieldValidator.require_string(db_dict_response, "slot_name")
	active_status = ApiFieldValidator.require_bool(db_dict_response, "active_status")
	last_played_at = ApiFieldValidator.require_string(
		db_dict_response, "last_played_at", ApiRegexConstants.ISO8601_REGEX
	)
	play_time_seconds = ApiFieldValidator.require_int(db_dict_response, "play_time_seconds")
	date_created = ApiFieldValidator.require_string(
		db_dict_response, "date_created", ApiRegexConstants.ISO8601_REGEX
	)
	date_modified = ApiFieldValidator.require_string(
		db_dict_response, "date_modified", ApiRegexConstants.ISO8601_REGEX
	)


static func err(message: String) -> ApiSlotResponseDto:
	return ApiSlotResponseDto.new({}, message)
