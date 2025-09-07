@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node
# Stores room base props + behaviors

# Why not use groups? Groups act weird and its deterministic this way
# We are 100% confident these are this room doors and player instance refs
var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	# Update local world state current room path with my path
	# TODO: Update layer 2 sql mem room table row, make this room current field be active
	WorldState.set_one_object_in_world_state_by_id(
		LocalWorldStateKeyConstants.CURRENT_ROOM_KEY,
		{LocalWorldStateKeyConstants.ROOM_SCENE_PATH_KEY: scene_file_path}
	)
	# Get player instance ref
	for child: Node in get_children():
		if child is Player:
			player = child
			break
	# Get save point instance ref
	# TODO: Do not do this, let autoload page manager emit signal, then room base class sub to it
	# TODO: Or have the page call get tree all savable groups to save
	for child: Node in get_children():
		if child is SavePoint:
			child.player_pressed_save_button.connect(
				_dump_my_savable_objects_state_to_local_world_state
			)
			break
	# Populate door instance dict map storage
	for child: Node in get_children():
		if child is Door:
			doors[child.name] = child
			child.player_entered.connect(_on_door_player_entered)
	# Call kids ready
	_kid_ready()


func _kid_ready() -> void:
	pass


func _set_player_position_to_door(new_room_entrance_door_name: String) -> void:
	var new_room_entrance_door_instance: Door = doors.get(new_room_entrance_door_name, null)
	if not new_room_entrance_door_instance:
		return
	player.reposition_to_door(new_room_entrance_door_instance.player_spawn_position.global_position)


func _on_door_player_entered(
	target_room_scene_path: String, new_room_entrance_door_name: String
) -> void:
	_dump_my_savable_objects_state_to_local_world_state()
	await get_tree().process_frame
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.add_child(new_room)
	new_room._set_player_position_to_door(new_room_entrance_door_name)
	self.free()


func _dump_my_savable_objects_state_to_local_world_state() -> void:
	for savable_node: Node in get_tree().get_nodes_in_group(GroupNameConstants.SAVABLES):
		if not savable_node.has_method("_dump_state_to_world"):
			pass
		savable_node._dump_state_to_world()
