class_name PlayerAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)

signal flip_h_changed

@export var animation_name_data: PlayerAnimationNameData


func _ready() -> void:
	_validate_gui(animation_name_data)
	animation_finished.connect(_on_animation_finished)


func set_face_direction(is_facing_left: bool) -> void:
	if flip_h == is_facing_left:
		return
	flip_h_changed.emit()
	flip_h = is_facing_left


func _on_animation_finished() -> void:
	play(animation_name_data.FOLLOWUPS[animation])
