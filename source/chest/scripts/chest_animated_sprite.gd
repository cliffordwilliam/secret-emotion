class_name ChestAnimatedSprite
extends AnimatedSprite2D
# Draw and animate sprite
# Validates GUI against my resource (animation name)

@export var animation_name_data: ChestAnimationNameData


func _ready():
	_validate_gui()


func _validate_gui():
	for anim in sprite_frames.get_animation_names():
		if anim not in animation_name_data.ALL:
			push_error("❌ GUI 'PlayerAnimatedSprite' animation name missing: '%s'" % anim)
			get_tree().quit(1)

	print("✅ GUI 'PlayerAnimatedSprite' animation name valid.")


func _on_chest_play_animation(animation_name: StringName) -> void:
	play(animation_name)
