class_name ChestCloseState
extends ChestState
# Chest closed


func enter(previous_state: State) -> void:
	if previous_state == chest_state_machine.chest_open_state:
		chest_animated_sprite.play(ChestAnimationNameData.CLOSE)
	else:
		chest_animated_sprite.skip_to_last_frame(ChestAnimationNameData.CLOSE)


func physics_process(_delta: float) -> void:
	if chest_input.is_up_tapped():
		if chest_animated_sprite.is_playing():
			return
		done.emit(chest_state_machine.chest_open_state)
