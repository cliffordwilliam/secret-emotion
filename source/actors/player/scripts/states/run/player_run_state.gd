class_name PlayerRunState
extends PlayerState
# Player running around

var exit_strategy_manager: PlayerRunStateExitStrategyManager = (
	PlayerRunStateExitStrategyManager.new()
)

@onready var run_step_sfx_timer: Timer = $RunStepSfxTimer


func enter(_previous_state: State) -> void:
	player_animation_sprite.flip_h_changed.connect(_on_player_animated_sprite_flip_h_changed)
	player_animation_sprite.play(PlayerAnimationNameData.TO_RUN)
	run_step_sfx_timer.timeout.connect(_on_run_step_sfx_timer_timeout)
	run_step_sfx_timer.wait_time = PlayerSoundEffectData.RUN_STEP_INTERVAL
	run_step_sfx_timer.start()


func exit() -> void:
	player_animation_sprite.flip_h_changed.disconnect(_on_player_animated_sprite_flip_h_changed)
	run_step_sfx_timer.timeout.disconnect(_on_run_step_sfx_timer_timeout)
	run_step_sfx_timer.stop()


func physics_process(_delta: float) -> void:
	var input_direction_x: int = player_input.get_input_direction_x()

	var strategy: PlayerRunStateBaseExitStrategy = exit_strategy_manager.get_strategy(self)
	if strategy:
		done.emit(strategy.get_next_state())
		return

	player.velocity.x = float(input_direction_x) * PlayerMovementData.RUN_SPEED
	player.move_and_slide()

	if not player.is_on_floor():
		done.emit(player_state_machine.player_fall_state)
		return

	player_animation_sprite.set_face_direction(player.velocity.x < 0.0)


func _on_player_animated_sprite_flip_h_changed() -> void:
	player_animation_sprite.play(PlayerAnimationNameData.TURN_TO_RUN)


func _on_run_step_sfx_timer_timeout() -> void:
	SoundEffect.play(SoundEffectFilePathContants.PLAYER_GRASS_FOOTSTEP_SFX_PATH)
