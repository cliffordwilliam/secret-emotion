class_name SavePoint
extends Area2D

@onready var save_point_input: PlayerInput = $PlayerInput
@onready var save_point_animated_sprite: AnimatedSprite2D = $SavePointAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker
@onready var save_menu: CenterContainer = $CanvasLayer/SaveMenu


func _physics_process(_delta: float) -> void:
	if save_point_input.is_up_tapped():
		get_tree().paused = true
		save_menu.show()


func _on_body_entered(_body: Node2D) -> void:
	save_point_input.set_enable_input(true)
	interaction_marker.set_active()


func _on_body_exited(_body: Node2D) -> void:
	save_point_input.set_enable_input(false)
	interaction_marker.set_inactive()
