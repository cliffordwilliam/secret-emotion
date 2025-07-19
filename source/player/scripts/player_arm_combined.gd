class_name PlayerArmCombined
extends AnimatedSprite2D

const IDLE = "idle"
const WALK = "walk"
const ALL = [
	IDLE,
	WALK,
]


func _ready():
	_validate_animation_sync()


func _validate_animation_sync():
	for anim in sprite_frames.get_animation_names():
		assert(anim in ALL, "Unexpected animation in resource: '%s'" % anim)

	print("✅ All GUI animation names are in const.")

	for anim in ALL:
		assert(
			sprite_frames.has_animation(anim),
			"Expected animation not found in resource: '%s'" % anim,
		)

	print("✅ All const animation names are in GUI.")
