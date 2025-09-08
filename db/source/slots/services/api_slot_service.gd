class_name ApiSlotService
extends RefCounted


static func create(slot_create_dto: ApiSlotCreateDto) -> ApiSlotResponseDto:
	var existing: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_create_dto.slot_name)
	if not existing.error:
		return _error("Slot name '%s' is already taken" % slot_create_dto.slot_name)

	return ApiSlotRepository.create(slot_create_dto.to_dict())


static func get_all() -> Array[ApiSlotResponseDto]:
	return ApiSlotRepository.get_all()


static func delete(slot_name_dto: ApiStringParamDto) -> ApiSlotResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return slot

	if ApiSlotRepository.delete_by_id(slot.slot_id):
		return slot
	return _error("Failed to delete slot '%s'" % slot_name_dto.string_param)


static func activate_slot_by_name(slot_name_dto: ApiStringParamDto) -> ApiSlotResponseDto:
	var target_slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if target_slot.error:
		return target_slot

	if target_slot.active_status:
		return target_slot

	ApiSlotRepository.deactivate_all()
	var success: bool = ApiSlotRepository.update(target_slot.slot_id, {"active_status": 1})
	if success:
		return ApiSlotRepository.get_by_id(target_slot.slot_id)

	return _error("Failed to activate slot '%s'" % slot_name_dto.string_param)


static func _error(message: String) -> ApiSlotResponseDto:
	return ApiSlotResponseDto.new({}, message)
