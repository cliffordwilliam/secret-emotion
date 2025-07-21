class_name PlayerAnimatedSprite
extends AnimatedSprite2D
# Validates GUI against my resource (animation name)

@export var animation_name_data: PlayerAnimationNameData


func _ready():
	_validate_gui_animation()


func _validate_gui_animation():
	for anim in sprite_frames.get_animation_names():
		if anim not in animation_name_data.ALL:
			push_error("❌ GUI animation 'player animated sprite' name missing: '%s'" % anim)
			get_tree().quit(1)

	print("✅ GUI animation 'player animated sprite' names are valid.")


func _on_player_play_animation(animation_name: StringName) -> void:
	play(animation_name)


func _on_player_face_direction(is_facing_left: bool) -> void:
	flip_h = is_facing_left
