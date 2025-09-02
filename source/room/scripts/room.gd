@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node
# Stores room base props

signal player_entered_door

var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	# Get player ref
	for child in get_children():
		if child is Player:
			player = child
			break
	# Populate door dict map storage
	for child in get_children():
		if child is Door:
			doors[child.name] = child
			child.player_entered.connect(_on_door_player_entered)
	# Make chests sub to my player_entered_door event
	# TODO: Collect all saveable stuff to a list
	# TODO: On door player entered, tell all saveable stuff to dump to local
	# TODO: Let save point emit here and do exactly what player hit on door
	for child in get_children():
		if child is Chest:
			player_entered_door.connect(child._on_room_player_entered_door)


func initialize_player_position_to_door(door_name: String) -> void:
	player.reposition_to_door(doors[door_name].player_spawn_position.global_position)


func _on_door_player_entered(target_room_scene_path: String, target_door_name: String) -> void:
	await get_tree().process_frame
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.add_child(new_room)
	new_room.initialize_player_position_to_door(target_door_name)
	player_entered_door.emit()
	self.free()
