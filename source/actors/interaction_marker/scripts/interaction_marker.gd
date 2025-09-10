@icon("res://source/actors/interaction_marker/assets/message-circle-more.svg")
class_name InteractionMarker
extends Sprite2D

const FADE_IN: StringName = "fade_in"
const FADE_OUT: StringName = "fade_out"
const FLOAT: StringName = "float"

@onready var fade_animator: AnimationPlayer = $FadeAnimator
@onready var float_animator: AnimationPlayer = $FloatAnimator


func appear() -> void:
	fade_animator.play(FADE_IN)
	float_animator.play(FLOAT)


func disappear() -> void:
	fade_animator.play(FADE_OUT)
	float_animator.pause()
