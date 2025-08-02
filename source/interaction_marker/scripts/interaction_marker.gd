@icon("res://source/interaction_marker/assets/message-circle-more.svg")
extends Sprite2D

@export var animation_name_data: InteractionMarkerAnimationNameData

@onready var fade_animator: AnimationPlayer = $FadeAnimator


func _ready() -> void:
	modulate.a = 0.0


func set_active() -> void:
	fade_animator.play(animation_name_data.FADE_IN)


func set_inactive() -> void:
	fade_animator.play(animation_name_data.FADE_OUT)
