class_name ManageSlot
extends RefCounted


static func create(slot_create_dto: SlotCreateDTO) -> SlotCreateDTO:
	var created_slot: Dictionary = SlotRepository.create(slot_create_dto.to_dict())
	return SlotCreateDTO.new(created_slot)
