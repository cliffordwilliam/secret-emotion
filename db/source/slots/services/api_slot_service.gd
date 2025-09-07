class_name ApiSlotService
extends RefCounted


static func create(slot_create_schema: ApiSlotCreateDto) -> APISlotResponseDTO:
	var existing: APISlotResponseDTO = ApiSlotRepository.get_by_slot_name(
		ApiSlotNameDto.new(slot_create_schema.slot_name)
	)
	if not existing.error:
		return _error("Given name '%s' is already taken" % slot_create_schema.slot_name)
	return ApiSlotRepository.create(slot_create_schema)


static func get_all() -> Array[APISlotResponseDTO]:
	return ApiSlotRepository.get_all()


static func delete(slot_get_by_name_schema: ApiSlotNameDto) -> APISlotResponseDTO:
	return ApiSlotRepository.delete(slot_get_by_name_schema)


static func activate_slot_by_name(target_slot_schema: ApiSlotNameDto) -> APISlotResponseDTO:
	var target_slot: APISlotResponseDTO = ApiSlotRepository.get_by_slot_name(target_slot_schema)
	if target_slot.error:
		return target_slot
	if target_slot.active_status:
		return target_slot
	ApiSlotRepository.deactivate_all()
	return ApiSlotRepository.activate_slot_by_name(target_slot_schema)


static func _error(message: String) -> APISlotResponseDTO:
	return APISlotResponseDTO.new({}, message)
