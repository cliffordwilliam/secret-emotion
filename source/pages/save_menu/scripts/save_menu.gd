class_name SaveMenu
extends CenterContainer

enum ActionType { SAVE, LOAD }
const FIRST_ROOM_PATH: String = "res://source/room/stages/village/scenes/VillageEntrance.tscn"
@export var action: ActionType = ActionType.LOAD

@onready var label: Label = $VBoxContainer/Label
@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2
@onready var button_3: Button = $VBoxContainer/Button3


func _ready() -> void:
	match action:
		ActionType.SAVE:
			process_mode = Node.PROCESS_MODE_WHEN_PAUSED
			label.text = "SAVE"
		ActionType.LOAD:
			label.text = "LOAD"
	button.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_0))
	button_2.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_1))
	button_3.pressed.connect(func() -> void: handle_button(WorldState.SaveSlot.SLOT_2))


func handle_button(slot: WorldState.SaveSlot) -> void:
	match action:
		ActionType.SAVE:
			for savable_node: SaveComponent in get_tree().get_nodes_in_group(
				GroupNameConstants.SAVABLES
			):
				savable_node.dump_state_to_world()
			WorldState.dump_to_disk(slot)
			hide()
			get_tree().paused = false
		ActionType.LOAD:
			WorldState.hydrate_world(slot)
			var raw_data: Dictionary = WorldState.get_world_state(
				WorldStateConstants.KEY_CURRENT_ROOM
			)
			if raw_data.is_empty():
				get_tree().change_scene_to_file(FIRST_ROOM_PATH)
				return

			get_tree().change_scene_to_file(raw_data[WorldStateConstants.KEY_ROOM_SCENE_PATH])
