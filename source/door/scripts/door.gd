class_name Door
extends Area2D
# Shout event if player enters it

signal player_entered(target_room_scene_path: String, target_door_name: String)

@export_file("*.tscn") var target_room_scene_path: String

@onready var player_spawn_position: Marker2D = $PlayerSpawnPosition


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(_body: Node):
	player_entered.emit(target_room_scene_path, self.name)
