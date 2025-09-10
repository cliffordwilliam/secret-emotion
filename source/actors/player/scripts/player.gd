class_name Player
extends CharacterBody2D

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_input: PlayerInput = $PlayerInput
@onready var player_animated_sprite: PlayerAnimatedSprite = $PlayerAnimatedSprite
@onready var player_save_component: PlayerSaveComponent = $PlayerSaveComponent


func _ready() -> void:
	player_save_component.read_world_state()


func _physics_process(delta: float) -> void:
	player_state_machine.physics_process(delta)


func reposition_to_door(given_global_position: Vector2) -> void:
	global_position = given_global_position


func _on_save_component_finished_reading() -> void:
	player_state_machine.start()
