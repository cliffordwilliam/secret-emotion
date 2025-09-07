class_name ApiSlotService
extends RefCounted
# Exposes public API to manage slots
# Expects DTO instances to enter service and repository


static func create(slot_create_dto: ApiSlotCreateDto) -> ApiSlotResponseDto:
	var existing: ApiSlotResponseDto = ApiSlotRepository.get_by_slot_name(
		ApiStringParamDto.new(slot_create_dto.slot_name, "slot")
	)
	if not existing.error:
		return _error("Given name '%s' is already taken" % slot_create_dto.slot_name)
	return ApiSlotRepository.create(slot_create_dto)


static func get_all() -> Array[ApiSlotResponseDto]:
	return ApiSlotRepository.get_all()


static func delete(slot_name_dto: ApiStringParamDto) -> ApiSlotResponseDto:
	return ApiSlotRepository.delete(slot_name_dto)


static func activate_slot_by_name(slot_name_dto: ApiStringParamDto) -> ApiSlotResponseDto:
	var target_slot: ApiSlotResponseDto = ApiSlotRepository.get_by_slot_name(slot_name_dto)
	if target_slot.error:
		return target_slot
	if target_slot.active_status:
		return target_slot
	ApiSlotRepository.deactivate_all()
	return ApiSlotRepository.activate_slot_by_name(slot_name_dto)


static func _error(message: String) -> ApiSlotResponseDto:
	return ApiSlotResponseDto.new({}, message)
