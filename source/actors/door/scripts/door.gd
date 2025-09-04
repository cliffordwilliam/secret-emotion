class_name Door
extends Area2D
# Emit player_entered event

signal player_entered(target_room_scene_path: String, target_door_name: StringName)

@export_file("*.tscn") var target_room_scene_path: String

@onready var player_spawn_position: Marker2D = $PlayerSpawnPosition


func _ready() -> void:
	body_entered.connect(_on_player_entered)


func _on_player_entered(_player: Player) -> void:
	player_entered.emit(target_room_scene_path, self.name)
