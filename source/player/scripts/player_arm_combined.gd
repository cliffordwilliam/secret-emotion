class_name PlayerArmCombined
extends AnimatedSprite2D

const IDLE: String = "idle"
const WALK: String = "walk"
const ALL_ANIMATIONS: Array[String] = [
	IDLE,
	WALK,
]


func _ready():
	_validate_animation_sync()


func _validate_animation_sync():
	for anim in sprite_frames.get_animation_names():
		if anim not in ALL_ANIMATIONS:
			push_error("❌ Unexpected animation in resource: '%s'" % anim)
			get_tree().quit(1)

	print("✅ All GUI animation names are in const.")

	for anim in ALL_ANIMATIONS:
		if not sprite_frames.has_animation(anim):
			push_error("❌ Expected animation not found in resource: '%s'" % anim)
			get_tree().quit(1)

	print("✅ All const animation names are in GUI.")
