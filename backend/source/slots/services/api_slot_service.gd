class_name ApiSlotService
extends RefCounted


static func create(slot_create_dto: ApiSlotCreateDto) -> ApiSlotResponseDto:
	var existing_slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_create_dto.slot_name)
	if not existing_slot.error:
		return ApiSlotResponseDto.err("Slot name '%s' is already taken" % slot_create_dto.slot_name)
	return ApiSlotRepository.create(slot_create_dto)


static func get_all() -> Array[ApiSlotResponseDto]:
	return ApiSlotRepository.get_all()


static func get_by_name(slot_name: String) -> ApiSlotResponseDto:
	return ApiSlotRepository.get_by_name(slot_name)


static func delete_by_name(slot_name_dto: ApiStringParamDto) -> ApiSlotResponseDto:
	var slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if slot.error:
		return slot
	if ApiSlotRepository.delete_by_id(slot.slot_id):
		return slot
	return ApiSlotResponseDto.err("Failed to delete slot '%s'" % slot_name_dto.string_param)


static func activate_by_name(slot_name_dto: ApiStringParamDto) -> ApiSlotResponseDto:
	var target_slot: ApiSlotResponseDto = ApiSlotRepository.get_by_name(slot_name_dto.string_param)
	if target_slot.error:
		return target_slot
	if target_slot.active_status:
		return target_slot
	ApiSlotRepository.deactivate_all()
	if ApiSlotRepository.activate_by_id(target_slot.slot_id):
		return ApiSlotRepository.get_by_id(target_slot.slot_id)
	return ApiSlotResponseDto.err("Failed to activate slot '%s'" % slot_name_dto.string_param)


static func get_active_slot() -> ApiSlotResponseDto:
	return ApiSlotRepository.get_active_slot()
