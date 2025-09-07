class_name APISlotResponseDTO
extends ApiBaseResponseDto

# Schema props
var slot_id: int
var slot_name: String
var active_status: bool
var last_played_at: String
var play_time_seconds: int
var date_created: String
var date_modified: String


# Will only instance when shape is valid
func _init(db_dict: Dictionary = {}, given_error_message: String = "") -> void:
	super._init(db_dict, given_error_message)
	# Quit early if this is error version, just need the parent given_error_message
	if error:
		return
	slot_id = int(db_dict.get("slot_id", 0))
	slot_name = str(db_dict.get("slot_name", ""))
	active_status = int(db_dict.get("active_status", 0)) != 0
	last_played_at = str(db_dict.get("last_played_at", ""))
	play_time_seconds = int(db_dict.get("play_time_seconds", 0))
	date_created = str(db_dict.get("date_created", ""))
	date_modified = str(db_dict.get("date_modified", ""))
