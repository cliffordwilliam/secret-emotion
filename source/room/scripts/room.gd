@icon("res://source/room/assets/layout-grid.svg")
class_name Room
extends Node
# Stores room base properties

signal position_player_to_door(global_position: Vector2)

var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	for child in get_children():
		if child is Player:
			player = child
			position_player_to_door.connect(player._on_enter_room_reposition_to_door)
	for child in get_children():
		if child is Door:
			doors[child.name] = child
			child.player_entered.connect(_on_door_player_entered)


func initialize_player_position_to_door(door_name: String) -> void:
	position_player_to_door.emit(doors[door_name].player_spawn_position.global_position)


func _on_door_player_entered(target_room_scene_path: String, target_door_name: String) -> void:
	await get_tree().process_frame
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.add_child(new_room)
	new_room.initialize_player_position_to_door(target_door_name)
	self.free()
