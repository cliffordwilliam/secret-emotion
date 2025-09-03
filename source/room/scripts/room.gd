@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node
# Stores room base props

var doors: Dictionary[String, Door] = {}
var player: Player


# TODO: Maybe better to put these into group? So not O(n)?
func _ready() -> void:
	# Dump my room_scene_path to local world state
	# This is base class script, so cannot use save component node
	WorldState.set_world_state(
		LocalWorldStateConstants.CURRENT_ROOM,
		{LocalWorldStateConstants.ROOM_SCENE_PATH: scene_file_path}
	)
	# Get player ref
	for child in get_children():
		if child is Player:
			player = child
			break
	# Get save point ref
	for child in get_children():
		if child is SavePoint:
			child.player_pressed_save_button.connect(_dump_my_savable_objects_state_to_world)
			break
	# Populate door dict map storage
	for child in get_children():
		if child is Door:
			doors[child.name] = child
			child.player_entered.connect(_on_door_player_entered)


func initialize_player_position_to_door(door_name: String) -> void:
	player.reposition_to_door(doors[door_name].player_spawn_position.global_position)


func _on_door_player_entered(target_room_scene_path: String, target_door_name: String) -> void:
	_dump_my_savable_objects_state_to_world()
	await get_tree().process_frame
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.add_child(new_room)
	new_room.initialize_player_position_to_door(target_door_name)
	self.free()


func _dump_my_savable_objects_state_to_world() -> void:
	for savable_node in get_tree().get_nodes_in_group(GroupNameConstants.SAVABLE):
		savable_node._dump_state_to_world()
