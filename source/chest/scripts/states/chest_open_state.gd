class_name ChestOpenState
extends ChestState
# Chest opened


func enter(previous_state: State) -> void:
	if previous_state and previous_state == chest_state_machine.chest_close_state:
		chest_animated_sprite.play(chest_animation_name_data.OPEN)
	else:
		chest_animated_sprite.skip_to_last_frame(chest_animation_name_data.OPEN)


func physics_process(_delta: float) -> void:
	if chest_input.is_up_tapped():
		done.emit(chest_state_machine.chest_close_state)
