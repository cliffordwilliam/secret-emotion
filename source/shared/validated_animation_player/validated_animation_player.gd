class_name ValidatedAnimationPlayerNode
extends AnimationPlayer
# Base class to validate AnimationPlayer animations against provided names


func _validate_gui(animation_name_data: Resource) -> void:
	for anim in get_animation_list():
		if anim not in animation_name_data.ALL:
			push_error("❌ GUI '%s' '%s' animation name missing: '%s'" % [get_class(), name, anim])
			get_tree().quit(1)

	print("✅ GUI '%s' '%s' animation name valid." % [get_class(), name])
