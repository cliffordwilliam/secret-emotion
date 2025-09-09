class_name Player
extends CharacterBody2D
# Listens to input and update its position with collision resolution

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_input: PlayerInput = $PlayerInput
@onready var player_animated_sprite: PlayerAnimatedSprite = $PlayerAnimatedSprite
@onready var player_save_component: PlayerSaveComponent = $PlayerSaveComponent


func _ready() -> void:
	player_state_machine.set_initial_state($PlayerStateMachine/PlayerIdleState)
	player_save_component.properties_initialized_by_save_file.connect(
		_on_player_save_component_finished
	)
	player_save_component.read_world_state()


func _physics_process(delta: float) -> void:
	player_state_machine.physics_process(delta)


func reposition_to_door(given_global_position: Vector2) -> void:
	global_position = given_global_position


func _dump_state_to_world(slot_name: String = "") -> void:
	player_save_component.dump_state_to_world(slot_name)


func _on_player_save_component_finished() -> void:
	player_state_machine.start()
