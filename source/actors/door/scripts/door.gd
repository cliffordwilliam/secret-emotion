class_name Door
extends Area2D

signal player_entered(target_room_scene_path: String, target_door_name: String)

@export_file("*.tscn") var target_room_scene_path: String

@onready var player_spawn_position: Marker2D = $PlayerSpawnPosition


func _on_body_entered(_body: Node) -> void:
	player_entered.emit(target_room_scene_path, name)
