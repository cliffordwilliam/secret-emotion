class_name PlayerAnimatedSprite
extends AnimatedSprite2D

signal flip_h_changed


func _ready() -> void:
	animation_finished.connect(_on_animation_finished)


func set_face_direction(is_facing_left: bool) -> void:
	if flip_h != is_facing_left:
		flip_h_changed.emit()
		flip_h = is_facing_left


func _on_animation_finished() -> void:
	play(PlayerAnimationNameData.FOLLOWUPS[animation])
