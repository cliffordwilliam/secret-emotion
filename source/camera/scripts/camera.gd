extends Camera2D

var target: Node2D = null


func _physics_process(_delta: float) -> void:
	if target:
		global_position = target.global_position


func _camera_follow(node: Node2D) -> void:
	target = node
