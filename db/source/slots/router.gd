class_name SlotsRouter
extends RefCounted


static func create_slot(data: Dictionary):
	var slot_create_dto: SlotCreateDTO = SlotCreateDTO.new(data)
	var created_slot: SlotCreateDTO = ManageSlot.create(slot_create_dto)
	return {"success": true, "data": created_slot.to_dict(), "meta": {}}
