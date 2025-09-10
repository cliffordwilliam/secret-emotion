class_name SavePoint
extends Area2D

@onready var save_point_input: PlayerInput = $PlayerInput
@onready var save_point_animated_sprite: AnimatedSprite2D = $SavePointAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker


func _physics_process(_delta: float) -> void:
	if save_point_input.is_up_tapped():
		PageRouter.show_page(PageNameConstants.SAVE_MENU_PAGE)


func _on_player_entered(_player: Node2D) -> void:
	save_point_input.listen_to_user_input()
	interaction_marker.appear()


func _on_player_exited(_player: Node2D) -> void:
	save_point_input.ignore_user_input()
	interaction_marker.disappear()
