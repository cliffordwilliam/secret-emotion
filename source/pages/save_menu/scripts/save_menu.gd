class_name SaveMenu
extends CenterContainer

signal player_pressed_save_button

enum ActionType { SAVE, LOAD }
@export var action: ActionType = ActionType.LOAD

@onready var label: Label = $VBoxContainer/Label
@onready var button: Button = $VBoxContainer/Button
@onready var button_2: Button = $VBoxContainer/Button2
@onready var button_3: Button = $VBoxContainer/Button3


func _ready() -> void:
	match action:
		ActionType.SAVE:
			# Save menu is opened from in game save points only
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
			player_pressed_save_button.emit()
			# Dump world to disk
			WorldState.save_to_slot(slot)
			# Hide myself and unpause the game
			hide()
			get_tree().paused = false
		ActionType.LOAD:
			# Disk -> local world state
			WorldState.load_from_slot(slot)
			# Read world state
			var raw_data: Dictionary = WorldState.get_world_state(
				LocalWorldStateConstants.CURRENT_ROOM
			)
			# Empty?
			if raw_data.is_empty():
				# Go to starting room
				# TODO: Move to constant?
				get_tree().change_scene_to_file(
					"res://source/room/stages/village/scenes/VillageEntrance.tscn"
				)
				return

			# Got something? Validate it
			if not raw_data.has(LocalWorldStateConstants.ROOM_SCENE_PATH):
				push_warning(
					(
						"Missing flip_h in player save data for id: %s"
						% LocalWorldStateConstants.CURRENT_ROOM
					)
				)
				return
			# TODO: Validate with regex that is it a valid path?

			# Go to room
			var path: String = raw_data[LocalWorldStateConstants.ROOM_SCENE_PATH]
			get_tree().change_scene_to_file(path)
