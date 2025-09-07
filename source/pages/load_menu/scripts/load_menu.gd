class_name LoadMenu
extends CanvasLayer
# Screen where user use their mouse to POST, GET, PATCH slots
# User can make new slot
# User can navigate slots
# User can make slot be active slot (this starts the game)

var ui_load_slot_item_scene: PackedScene = preload(
	"res://source/shared/ui_components/load_slot_item/scenes/UiLoadSlotItem.tscn"
)

@onready var new_slot_text_field: LineEdit = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready var create_new_slot: Button = $MarginContainer/VBoxContainer/HBoxContainer/CreateNewSlot
@onready
var slots_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/SlotsContainer


func _ready() -> void:
	create_new_slot.pressed.connect(_handle_create_slot)
	_rehydrate_slot_list()


func _handle_load(slot_name: String) -> void:
	var activated_slot: APISlotResponseDTO = ApiSlotService.activate_slot_by_name(
		ApiSlotNameDto.new(slot_name)
	)
	# Handle BAD
	if activated_slot.error:
		# TODO: Toast
		print(activated_slot.error_message)
	# Handle OK
	else:
		print("Slot '%s' is now active!" % activated_slot.slot_name)


func _handle_delete(slot_name: String) -> void:
	var deleted_slot_instance: APISlotResponseDTO = ApiSlotService.delete(
		ApiSlotNameDto.new(slot_name)
	)
	# Handle BAD
	if deleted_slot_instance.error:
		# TODO: Toast
		print(deleted_slot_instance.error_message)
	# Handle OK
	else:
		print("OK: Deleted a slot with name: '%s'" % deleted_slot_instance.slot_name)
		_rehydrate_slot_list()


func _handle_create_slot() -> void:
	var new_slot_name: String = new_slot_text_field.text
	var slot_create_schema: ApiSlotCreateDto = ApiSlotCreateDto.new({"slot_name": new_slot_name})
	var created_slot_instance: APISlotResponseDTO = ApiSlotService.create(slot_create_schema)
	# Handle BAD
	if created_slot_instance.error:
		# TODO: Toast
		print(created_slot_instance.error_message)
	# Handle OK
	else:
		print("OK: Made a new slot")
		_rehydrate_slot_list()


func _rehydrate_slot_list() -> void:
	_empty_slot_container()
	_fill_slot_container()


func _empty_slot_container() -> void:
	for child: Node in slots_container.get_children():
		child.queue_free()


func _fill_slot_container() -> void:
	var slots: Array[APISlotResponseDTO] = ApiSlotService.get_all()
	for slot: APISlotResponseDTO in slots:
		var ui_load_slot_item_instance: UiLoadSlotItem = ui_load_slot_item_scene.instantiate()
		slots_container.add_child(ui_load_slot_item_instance)
		ui_load_slot_item_instance.initialize(slot.slot_name)
		ui_load_slot_item_instance.load_button_pressed.connect(_handle_load)
		ui_load_slot_item_instance.delete_button_pressed.connect(_handle_delete)
