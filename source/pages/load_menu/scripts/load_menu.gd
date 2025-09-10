class_name LoadMenu
extends Page

const FIRST_ROOM_PATH: String = "res://source/room/stages/village/scenes/VillageEntrance.tscn"
@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2
@onready var button_3: Button = $VBoxContainer/Button3


func _ready() -> void:
	button.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_0))
	button_2.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_1))
	button_3.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_2))


func handle_button(slot: WorldState.SaveSlot) -> void:
	WorldState.hydrate_world(slot)
	var raw_data: Dictionary = WorldState.get_world_state(WorldStateConstants.KEY_CURRENT_ROOM)
	if raw_data.is_empty():
		get_tree().change_scene_to_file(FIRST_ROOM_PATH)
		return
	get_tree().change_scene_to_file(raw_data[WorldStateConstants.KEY_ROOM_SCENE_PATH])
	PageRouter.show_page(PageNameConstants.BLANK_PAGE)
