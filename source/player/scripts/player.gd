class_name Player
extends CharacterBody2D
# Listens to input and update its position with collision resolution

@export var sound_effect_data: PlayerSoundEffectData
@export var movement_data: PlayerMovementData
@export var animation_name_data: PlayerAnimationNameData

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var player_input: PlayerInput = $PlayerInput
@onready var player_animated_sprite: PlayerAnimatedSprite = $PlayerAnimatedSprite


func _ready() -> void:
	await owner.ready
	player_state_machine.start()


func _physics_process(delta):
	player_state_machine.physics_process(delta)


func reposition_to_door(given_global_position: Vector2) -> void:
	global_position = given_global_position
