class_name ValidatedAnimationPlayer
extends AnimationPlayer
# Base class that have _validate_gui func for AnimationPlayer kids to use
# Validates external engine values against codebase const (animation names)


# TODO: Can activate global error boundary
func _validate_gui(animation_names: Array[StringName]) -> void:
	for anim: String in get_animation_list():
		if anim not in animation_names:
			push_error("❌ GUI '%s' '%s' animation name missing: '%s'" % [get_class(), name, anim])
			get_tree().quit(1)

	print("✅ GUI '%s' '%s' animation name valid." % [get_class(), name])
