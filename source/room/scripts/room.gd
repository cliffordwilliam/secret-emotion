@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node

var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	WorldState.set_world_state(
		WorldStateConstants.KEY_CURRENT_ROOM,
		{WorldStateConstants.KEY_ROOM_SCENE_PATH: scene_file_path}
	)
	for child: Node in get_children():
		if child is Player:
			player = child
			break
	for child: Node in get_children():
		if child is Door:
			doors[child.name] = child
			child.player_entered.connect(_on_door_player_entered)


func kid_ready() -> void:
	pass


func initialize_player_position_to_door(door_name: String) -> void:
	player.reposition_to_door(doors[door_name].player_spawn_position.global_position)


func _on_door_player_entered(target_room_scene_path: String, target_door_name: String) -> void:
	for savable_node: SaveComponent in get_tree().get_nodes_in_group(GroupNameConstants.SAVABLES):
		savable_node.dump_state_to_world()
	await get_tree().process_frame
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.add_child(new_room)
	new_room.initialize_player_position_to_door(target_door_name)
	free()
