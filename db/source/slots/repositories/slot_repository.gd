class_name SlotRepository
extends RefCounted


static func create(slot_create_dict: Dictionary) -> Dictionary:
	ApiSqlite.database.insert_row("slots", slot_create_dict)
	return get_by_label(slot_create_dict.label)


static func get_by_label(label: String) -> Variant:
	var results: Array[Dictionary] = ApiSqlite.database.select_rows(
		"slots", "label = '%s'" % label, ["*"]
	)
	if results.is_empty():
		return null
	return results[0]
