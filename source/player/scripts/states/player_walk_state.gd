class_name PlayerWalkState
extends PlayerState


func _ready() -> void:
	state_name = "walk"


func enter() -> void:
	player.player_arm_combined.play(player.player_arm_combined.WALK)


func physics_process(_delta: float) -> void:
	var input_direction_x: float = Input.get_axis(
		InputConstants.LEFT_INPUT, InputConstants.RIGHT_INPUT
	)

	player.velocity.x = input_direction_x * player.player_movement_data.WALK_SPEED
	player.move_and_slide()

	if is_equal_approx(input_direction_x, 0.0):
		done.emit(player_state_machine.player_idle_state.state_name)
		return

	player.player_arm_combined.flip_h = player.velocity.x < 0.0
