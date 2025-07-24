class_name PlayerAnimatedSprite
extends AnimatedSprite2D
# Draw and animate sprite
# Validates GUI against my resource (animation name)

signal flip_h_changed

@export var animation_name_data: PlayerAnimationNameData


func _ready():
	_validate_gui()


func _validate_gui():
	for anim in sprite_frames.get_animation_names():
		if anim not in animation_name_data.ALL:
			push_error("❌ GUI 'PlayerAnimatedSprite' animation name missing: '%s'" % anim)
			get_tree().quit(1)

	print("✅ GUI 'PlayerAnimatedSprite' animation name valid.")


func _on_player_play_animation(animation_name: StringName) -> void:
	play(animation_name)


func _on_player_face_direction(is_facing_left: bool) -> void:
	if flip_h == is_facing_left:
		return
	flip_h_changed.emit()
	flip_h = is_facing_left


func _on_animation_finished() -> void:
	play(animation_name_data.FOLLOWUPS[animation])
