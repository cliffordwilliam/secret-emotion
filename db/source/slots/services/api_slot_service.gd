class_name APISlotService
extends RefCounted


static func create(slot_create_schema: APISlotCreateDTO) -> APISlotResponseDTO:
	var existing: APISlotResponseDTO = APISlotRepository.get_by_slot_name(
		APISlotNameDTO.new(slot_create_schema.slot_name)
	)
	if not existing.error:
		return _error("Given name '%s' is already taken" % slot_create_schema.slot_name)
	return APISlotRepository.create(slot_create_schema)


static func get_all() -> Array[APISlotResponseDTO]:
	return APISlotRepository.get_all()


static func delete(slot_get_by_name_schema: APISlotNameDTO) -> APISlotResponseDTO:
	return APISlotRepository.delete(slot_get_by_name_schema)


static func activate_slot_by_name(target_slot_schema: APISlotNameDTO) -> APISlotResponseDTO:
	var target_slot: APISlotResponseDTO = APISlotRepository.get_by_slot_name(target_slot_schema)
	if target_slot.error:
		return target_slot
	if target_slot.active_status:
		return target_slot
	APISlotRepository.deactivate_all()
	return APISlotRepository.activate_slot_by_name(target_slot_schema)


static func _error(message: String) -> APISlotResponseDTO:
	return APISlotResponseDTO.new({}, message)
