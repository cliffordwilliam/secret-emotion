class_name ApiPlayerResponseDto
extends ApiBaseResponseDto

var player_id: int
var slot_id: int
var pos_x: float
var pos_y: float
var flip_h: bool
var date_created: String
var date_modified: String


func _init(db_dict_response: Dictionary = {}, given_error_message: String = "") -> void:
	super._init(db_dict_response, given_error_message)
	if error:
		return

	player_id = ApiFieldValidator.require_int(db_dict_response, "player_id", true)
	slot_id = ApiFieldValidator.require_int(db_dict_response, "slot_id", true)
	pos_x = ApiFieldValidator.require_float(db_dict_response, "pos_x")
	pos_y = ApiFieldValidator.require_float(db_dict_response, "pos_y")
	flip_h = ApiFieldValidator.require_bool(db_dict_response, "flip_h")
	date_created = ApiFieldValidator.require_string(
		db_dict_response, "date_created", ApiRegexConstants.ISO8601_REGEX
	)
	date_modified = ApiFieldValidator.require_string(
		db_dict_response, "date_modified", ApiRegexConstants.ISO8601_REGEX
	)


static func err(message: String) -> ApiPlayerResponseDto:
	return ApiPlayerResponseDto.new({}, message)
