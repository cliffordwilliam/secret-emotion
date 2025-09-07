class_name ApiRoomRepository
extends RefCounted


# Create a new room
static func create(room_create_schema: ApiRoomCreateDto) -> ApiRoomResponseDto:
	ApiSqlite.database.insert_row("rooms", room_create_schema.to_dict())
	return get_by_room_name_and_slot(room_create_schema.slot_id, room_create_schema.room_name)


# Fetch room by slot and name
static func get_by_room_name_and_slot(slot_id: int, room_name: String) -> ApiRoomResponseDto:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "slot_id = %d AND room_name = '%s'" % [slot_id, room_name], ["*"]
	)
	if raw_results.is_empty():
		return _error("Room '%s' for slot %d not found" % [room_name, slot_id])
	return ApiRoomResponseDto.new(raw_results[0])


# Internal error handler
static func _error(message: String) -> ApiRoomResponseDto:
	return ApiRoomResponseDto.new({}, message)
