class_name OverlaySaveMenuPage
extends OverlayPage

var ui_save_slot_item_scene: PackedScene = preload(
	SceneFilePathContants.UI_SAVE_SLOT_ITEM_SCENE_PATH
)

@onready var page_title: Label = $MarginContainer/VBoxContainer/PageTitle
@onready
var slots_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/SlotsContainer


func _ready() -> void:
	# TODO: This is fine, we use localization later here, there is a built in data type to use
	page_title.text = "Save game"
	_rehydrate_slot_list()


func _rehydrate_slot_list() -> void:
	await get_tree().process_frame
	_empty_slot_container()
	_fill_slot_container()


func _empty_slot_container() -> void:
	for child: UiSaveSlotItem in slots_container.get_children():
		child.free()


func _handle_save(slot_name: String) -> void:
	# 1. Tell savables to hydrate sqlite mem (use unique to PATCH)
	for savable_node: Node in get_tree().get_nodes_in_group(GroupNameConstants.SAVABLES):
		savable_node._dump_state_to_world(slot_name)
	# 2. Then dump sqlite mem to disk as JSON Here
	ApiSqlite.dump_mem_to_disk_json()
	# 3. Change page back to blank page
	OverlayPageManager.change_page(SceneFilePathContants.OVERLAY_BLANK_SCENE_PATH)


func _fill_slot_container() -> void:
	var slots: Array[ApiSlotResponseDto] = ApiSlotService.get_all()
	for slot: ApiSlotResponseDto in slots:
		var ui_save_slot_item_instance: UiSaveSlotItem = ui_save_slot_item_scene.instantiate()
		slots_container.add_child(ui_save_slot_item_instance)
		ui_save_slot_item_instance.initialize(slot.slot_name)
		ui_save_slot_item_instance.save_button_pressed.connect(_handle_save)
