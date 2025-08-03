class_name ChestAnimatedSprite
extends ValidatedAnimatedSprite
# Draw and animate sprite
# Validates GUI against my resource (animation name)

@export var animation_name_data: ChestAnimationNameData


func _ready():
	_validate_gui(animation_name_data)


func _on_chest_play_animation(animation_name: StringName) -> void:
	play(animation_name)


func _on_chest_skip_to_last_frame(animation_name: StringName) -> void:
	play(animation_name)
	frame = sprite_frames.get_frame_count(animation_name)
