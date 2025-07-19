class_name Player
extends CharacterBody2D

@export var player_movement_data: PlayerMovementData

@onready var player_arm_combined: AnimatedSprite2D = $PlayerArmCombined
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine


func _ready() -> void:
	player_state_machine.setup_states(self)


func _physics_process(delta):
	player_state_machine.physics_process(delta)
