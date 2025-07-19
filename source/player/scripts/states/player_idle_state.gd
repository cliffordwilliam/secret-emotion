class_name PlayerIdleState
extends PlayerState


func _ready() -> void:
	state_name = "idle"


func enter() -> void:
	player.velocity.x = 0.0
	player.player_arm_combined.play(player.player_arm_combined.IDLE)


func physics_process(_delta: float) -> void:
	if Input.get_axis(InputConstants.LEFT_INPUT, InputConstants.RIGHT_INPUT):
		done.emit(player_state_machine.player_walk_state.state_name)
