@icon("res://source/actors/chest/assets/archive.svg")
class_name Chest
extends Area2D

@onready var chest_state_machine: ChestStateMachine = $ChestStateMachine
@onready var chest_input: PlayerInput = $PlayerInput
@onready var chest_animated_sprite: ChestAnimatedSprite = $ChestAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker
@onready var chest_save_component: ChestSaveComponent = $ChestSaveComponent


func _ready() -> void:
	chest_save_component.read_world_state()


func _physics_process(delta: float) -> void:
	chest_state_machine.physics_process(delta)


func _on_player_entered(_player: Node2D) -> void:
	chest_input.listen_to_user_input()
	interaction_marker.appear()


func _on_player_exited(_player: Node2D) -> void:
	chest_input.ignore_user_input()
	interaction_marker.disappear()


func _on_save_component_finished_reading() -> void:
	chest_state_machine.start()
