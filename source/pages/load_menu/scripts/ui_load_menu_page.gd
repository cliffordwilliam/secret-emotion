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
@onready var page_title: Label = $MarginContainer/VBoxContainer/PageTitle


func _ready() -> void:
	# TODO: This is fine, we use localization later here, there is a built in data type to use
	page_title.text = "Load game"
	new_slot_text_field.placeholder_text = "Create new slot"
	create_new_slot_button.pressed.connect(_handle_create_slot)
	_rehydrate_slot_list()


func _handle_load(slot_name: String) -> void:
	var activated_slot: ApiSlotResponseDto = ApiSlotService.activate_by_name(
		ApiStringParamDto.new(slot_name)
	)
	if activated_slot.error:
		return
	var active_room: ApiRoomResponseDto = ApiRoomService.get_active_room_by_slot_name(
		ApiStringParamDto.new(activated_slot.slot_name)
	)
	if active_room.error:
		return

	await get_tree().process_frame
	get_tree().change_scene_to_file(active_room.scene_file_path)


func _handle_delete(slot_name: String) -> void:
	var deleted_slot: ApiSlotResponseDto = ApiSlotService.delete_by_name(
		ApiStringParamDto.new(slot_name)
	)
	if deleted_slot.error:
		return
	ApiSqlite.dump_mem_to_disk_json()
	_rehydrate_slot_list()


func _handle_create_slot() -> void:
	if new_slot_text_field.text == "":
		return
	var created_slot: ApiSlotResponseDto = ApiSlotService.create(
		ApiSlotCreateDto.new({"slot_name": new_slot_text_field.text})
	)
	if created_slot.error:
		return
	_rehydrate_slot_list()
	new_slot_text_field.text = ""

	var created_player: ApiPlayerResponseDto = (
		ApiPlayerService
		. create(
			ApiStringParamDto.new(created_slot.slot_name),
			(
				ApiPlayerCreateDto
				. new(
					{
						"player_pos_x": UiLoadMenuConfigData.FIRST_STARTING_PLAYER_POSITION_X,
						"player_pos_y": UiLoadMenuConfigData.FIRST_STARTING_PLAYER_POSITION_Y,
						"flip_h": UiLoadMenuConfigData.FIRST_STARTING_PLAYER_FLIP_H,
					}
				)
			)
		)
	)
	if created_player.error:
		return

	var created_room: ApiRoomResponseDto = (
		ApiRoomService
		. create(
			ApiStringParamDto.new(created_slot.slot_name),
			(
				ApiRoomCreateDto
				. new(
					{
						"room_name": UiLoadMenuConfigData.FIRST_STARTING_ROOM_NAME,
						"scene_file_path": UiLoadMenuConfigData.FIRST_STARTING_ROOM_SCENE_FILE_PATH,
						"active_status": true,
					}
				)
			)
		)
	)
	if created_room.error:
		return
	ApiSqlite.dump_mem_to_disk_json()


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
