@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node
# Stores room base properties

signal room_changed
signal position_player_to_door_request(global_position: Vector2)

var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	# Get player ref
	for child in get_children():
		if child is Player:
			position_player_to_door_request.connect(child._reposition_to_door_request)
			break
	# Populate door dict map storage
	for child in get_children():
		if child is Door:
			doors[child.name] = child
			child.player_entered.connect(_on_door_player_entered)
	# Make chests sub to my room changed event
	for child in get_children():
		if child is Chest:
			room_changed.connect(child._on_room_changed)


func initialize_player_position_to_door(door_name: String) -> void:
	position_player_to_door_request.emit(doors[door_name].player_spawn_position.global_position)


func _on_door_player_entered(target_room_scene_path: String, target_door_name: String) -> void:
	await get_tree().process_frame
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.add_child(new_room)
	new_room.initialize_player_position_to_door(target_door_name)
	room_changed.emit()
	self.free()
