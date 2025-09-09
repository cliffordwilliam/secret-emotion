@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node
# Stores room base props + behaviors

var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	# Get player instance ref
	for child: Node in get_children():
		if child is Player:
			player = child
			break
	# Get save point instance ref
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

	_activate_new_room(new_room)

	get_tree().root.add_child(new_room)
	new_room._set_player_position_to_door(new_room_entrance_door_name)
	self.free()


func _dump_my_savable_objects_state_to_local_world_state() -> void:
	for savable_node: Node in get_tree().get_nodes_in_group(GroupNameConstants.SAVABLES):
		savable_node._dump_state_to_world()


func _activate_new_room(new_room: Room) -> void:
	var found_active_slot: ApiSlotResponseDto = ApiSlotService.get_active_slot()
	if found_active_slot.error:
		return

	var activated_room: ApiRoomResponseDto = (
		ApiRoomService
		. activate_room_by_name_and_slot_name(
			ApiStringParamDto.new(new_room.name),
			ApiStringParamDto.new(found_active_slot.slot_name),
		)
	)
	if not activated_room.error:
		return

	var new_active_room: ApiRoomResponseDto = ApiRoomService.create(
		ApiStringParamDto.new(found_active_slot.slot_name),
		ApiRoomCreateDto.new(
			{
				"room_name": new_room.name,
				"scene_file_path": new_room.scene_file_path,
				"active_status": 1
			}
		)
	)
	if new_active_room.error:
		return
