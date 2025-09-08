class_name ApiRoomRepository
extends RefCounted


static func create(slot_id: int, room_create_schema: ApiRoomCreateDto) -> ApiRoomResponseDto:
	var insert_data: Dictionary = {
		"slot_id": slot_id,
		"room_name": room_create_schema.room_name,
		"scene_file_path": room_create_schema.scene_file_path,
		"current_room": 1 if room_create_schema.current_room else 0
	}
	ApiSqlite.database.insert_row("rooms", insert_data)
	return get_by_slot_and_name(slot_id, room_create_schema.room_name)


static func get_by_slot_and_name(slot_id: int, room_name: String) -> ApiRoomResponseDto:
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "slot_id = %d AND room_name = '%s'" % [slot_id, room_name], ["*"]
	)
	if raw_results.is_empty():
		return _error("Room '%s' not found for slot_id %d" % [room_name, slot_id])
	return ApiRoomResponseDto.new(raw_results[0])


static func get_current_room(slot_id: int) -> ApiRoomResponseDto:
	# OK
	var raw_results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"rooms", "slot_id = %d AND current_room = 1" % slot_id, ["*"]
	)
	if raw_results.is_empty():
		return _error("No current room found for slot_id %d" % slot_id)
	return ApiRoomResponseDto.new(raw_results[0])


static func update(room_id: int, update_data: Dictionary) -> ApiRoomResponseDto:
	var rows_updated: int = ApiSqlite.database.update_rows(
		"rooms", "room_id = %d" % room_id, update_data
	)
	if rows_updated > 0:
		var results: Array[Dictionary] = ApiSqlite.database.select_rows(
			"rooms", "room_id = %d" % room_id, ["*"]
		)
		if not results.is_empty():
			return ApiRoomResponseDto.new(results[0])
	return _error("Failed to update room_id %d" % room_id)


static func _error(message: String) -> ApiRoomResponseDto:
	return ApiRoomResponseDto.new({}, message)
