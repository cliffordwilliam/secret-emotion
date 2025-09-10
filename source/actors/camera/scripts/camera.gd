class_name Camera
extends Camera2D

@export var target: Node2D


func _physics_process(_delta: float) -> void:
	global_position = target.global_position


func set_target(node: Node2D) -> void:
	target = node
