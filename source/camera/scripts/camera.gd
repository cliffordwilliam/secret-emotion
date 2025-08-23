class_name Camera
extends Camera2D

var target: Node2D = null


func _physics_process(_delta: float) -> void:
	if target:
		global_position = target.global_position


func set_target(node: Node2D) -> void:
	target = node
