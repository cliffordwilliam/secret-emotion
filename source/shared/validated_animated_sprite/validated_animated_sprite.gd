class_name ValidatedAnimatedSprite
extends AnimatedSprite2D
# Base class to validate AnimatedSprite2D animations against provided names


func _validate_gui(animation_name_data: Resource):
	for anim in sprite_frames.get_animation_names():
		if anim not in animation_name_data.ALL:
			push_error("❌ GUI '%s' '%s' animation name missing: '%s'" % [get_class(), name, anim])
			get_tree().quit(1)

	print("✅ GUI '%s' '%s' animation name valid." % [get_class(), name])
