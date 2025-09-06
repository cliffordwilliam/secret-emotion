@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node
# Stores room base props + behaviors

var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	# Update local world state current room path with my path
	WorldState.set_one_object_in_world_state_by_id(
		LocalWorldStateKeyConstants.CURRENT_ROOM_KEY,
		{LocalWorldStateKeyConstants.ROOM_SCENE_PATH_KEY: scene_file_path}
	)
	# Get player ref
	for child: Node in get_children():
		if child is Player:
			player = child
			break
	# Get save point ref
	for child: Node in get_children():
		if child is SavePoint:
			child.player_pressed_save_button.connect(
				_dump_my_savable_objects_state_to_local_world_state
			)
			break
	# Populate door dict map storage
	for child: Node in get_children():
		if child is Door:
			doors[child.name] = child
			child.player_entered.connect(_on_door_player_entered)


func _set_player_position_to_door(door_name: String) -> void:
	player.reposition_to_door(doors[door_name].player_spawn_position.global_position)


func _on_door_player_entered(target_room_scene_path: String, target_door_name: String) -> void:
	_dump_my_savable_objects_state_to_local_world_state()
	await get_tree().process_frame
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.add_child(new_room)
	new_room._set_player_position_to_door(target_door_name)
	self.free()


func _dump_my_savable_objects_state_to_local_world_state() -> void:
	for savable_node: Node in get_tree().get_nodes_in_group(GroupNameConstants.SAVABLES):
		savable_node._dump_state_to_world()
