class_name ApiRoomService
extends RefCounted
# Exposes public API to manage rooms
# Expects DTO instances to enter service and repository


static func create(room_create_dto: ApiRoomCreateDto) -> ApiRoomResponseDto:
	# Check if a room with the same name already exists for this slot
	var existing: ApiRoomResponseDto = ApiRoomRepository.get_by_room_name_and_slot(
		room_create_dto.slot_id, room_create_dto.room_name
	)
	if not existing.error:
		return _error("Room name '%s' is already taken for this slot" % room_create_dto.room_name)

	# Otherwise, create the new room
	return ApiRoomRepository.create(room_create_dto)


# Internal error helper
static func _error(message: String) -> ApiRoomResponseDto:
	return ApiRoomResponseDto.new({}, message)
