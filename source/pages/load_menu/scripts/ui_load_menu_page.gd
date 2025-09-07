class_name UiLoadMenuPage
extends CanvasLayer
# Page where user use their mouse load a slot

var ui_load_slot_item_scene: PackedScene = preload(
	SceneFilePathContants.UI_LOAD_SLOT_ITEM_SCENE_PATH
)

@onready var new_slot_text_field: LineEdit = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit
@onready
var create_new_slot_button: Button = $MarginContainer/VBoxContainer/HBoxContainer/CreateNewSlot
@onready
var slots_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/SlotsContainer


func _ready() -> void:
	create_new_slot_button.pressed.connect(_handle_create_slot)
	_rehydrate_slot_list()


func _handle_load(slot_name: String) -> void:
	var activated_slot_response_dto: ApiSlotResponseDto = ApiSlotService.activate_slot_by_name(
		ApiStringParamDto.new(slot_name, "UiLoadMenuPage _handle_load")
	)
	# Handle BAD
	if activated_slot_response_dto.error:
		# TODO: Toast
		print(activated_slot_response_dto.error_message)
	# Handle OK
	else:
		print("Slot '%s' is now active!" % activated_slot_response_dto.slot_name)


func _handle_delete(slot_name: String) -> void:
	var deleted_slot_response_dto: ApiSlotResponseDto = ApiSlotService.delete(
		ApiStringParamDto.new(slot_name, "UiLoadMenuPage _handle_delete")
	)
	# Handle BAD
	if deleted_slot_response_dto.error:
		# TODO: Toast
		print(deleted_slot_response_dto.error_message)
	# Handle OK
	else:
		print("OK: Deleted a slot with name: '%s'" % deleted_slot_response_dto.slot_name)
		_rehydrate_slot_list()


func _handle_create_slot() -> void:
	# Recoverable/user-fixable errors, do not go to global error handler, let user fix it here
	if new_slot_text_field.text == "":
		# TODO: Toast
		return
	var created_slot_response_dto: ApiSlotResponseDto = ApiSlotService.create(
		ApiSlotCreateDto.new({"slot_name": new_slot_text_field.text})
	)
	# Handle BAD
	if created_slot_response_dto.error:
		# TODO: Toast
		print(created_slot_response_dto.error_message)
	# Handle OK
	else:
		print("OK: Made a new slot")
		_rehydrate_slot_list()
		new_slot_text_field.text = ""


func _rehydrate_slot_list() -> void:
	await get_tree().process_frame
	_empty_slot_container()
	_fill_slot_container()


func _empty_slot_container() -> void:
	for child: UiLoadSlotItem in slots_container.get_children():
		child.free()


func _fill_slot_container() -> void:
	var slots: Array[ApiSlotResponseDto] = ApiSlotService.get_all()
	for slot: ApiSlotResponseDto in slots:
		var ui_load_slot_item_instance: UiLoadSlotItem = ui_load_slot_item_scene.instantiate()
		slots_container.add_child(ui_load_slot_item_instance)
		ui_load_slot_item_instance.initialize(slot.slot_name)
		ui_load_slot_item_instance.load_button_pressed.connect(_handle_load)
		ui_load_slot_item_instance.delete_button_pressed.connect(_handle_delete)
