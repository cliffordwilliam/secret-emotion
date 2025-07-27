class_name Room
extends Node
# Stores all room base properties

var doors: Dictionary[String, Door] = {}
var player: Player


func _ready() -> void:
	for child: Player in find_children("*", "Player"):
		player = child
	for child: Door in find_children("*", "Door"):
		doors[child.name] = child
		child.player_entered.connect(_on_door_player_entered)


func initialize_player_position_to_door(door_name: String) -> void:
	await self.ready
	player.global_position = doors[door_name].player_spawn_position.global_position


func _on_door_player_entered(target_room_scene_path: String, target_door_name: String) -> void:
	self.queue_free()
	var new_room: Room = load(target_room_scene_path).instantiate()
	get_tree().root.call_deferred("add_child", new_room)
	new_room.initialize_player_position_to_door(target_door_name)
