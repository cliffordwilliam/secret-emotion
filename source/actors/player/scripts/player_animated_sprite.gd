class_name PlayerAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)

signal flip_h_changed


func _ready() -> void:
	_validate_gui(PlayerAnimationNameData.ALL)
	animation_finished.connect(_on_animation_finished)


func set_face_direction(is_facing_left: bool) -> void:
	if flip_h == is_facing_left:
		return
	flip_h = is_facing_left
	flip_h_changed.emit()


func _on_animation_finished() -> void:
	play(PlayerAnimationNameData.FOLLOWUPS[animation])
