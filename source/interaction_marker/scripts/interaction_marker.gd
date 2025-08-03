@icon("res://source/interaction_marker/assets/message-circle-more.svg")
extends Sprite2D

@export var animation_name_data: InteractionMarkerAnimationNameData

@onready var fade_animator: AnimationPlayer = $FadeAnimator


func _ready() -> void:
	_validate_gui()
	modulate.a = 0.0


func _validate_gui():
	for anim in fade_animator.get_animation_list():
		if anim not in animation_name_data.ALL:
			push_error("❌ GUI 'InteractionMarker' animation name missing: '%s'" % anim)
			get_tree().quit(1)

	print("✅ GUI 'InteractionMarker' animation name valid.")


func set_active() -> void:
	fade_animator.play(animation_name_data.FADE_IN)


func set_inactive() -> void:
	fade_animator.play(animation_name_data.FADE_OUT)
