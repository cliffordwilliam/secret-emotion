class_name Player
extends CharacterBody2D

# Disk -> props
var movement_data: PlayerMovementData = (
	preload("res://source/player/resources/player_movement_data.tres").duplicate().init()
)

@onready var player_arm_combined: AnimatedSprite2D = $PlayerArmCombined
@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine


func _physics_process(delta):
	player_state_machine.physics_process(delta)


# States common methods
func get_dir() -> int:
	return int(Input.get_axis(InputConstants.LEFT_INPUT, InputConstants.RIGHT_INPUT))
