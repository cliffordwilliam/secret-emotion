class_name ChestCloseState
extends ChestState
# Chest closed


func enter(previous_state: State) -> void:
	if previous_state == chest_state_machine.chest_open_state:
		chest.play_animation.emit(chest_animation_name_data.CLOSE)


func physics_process(_delta: float) -> void:
	if chest_input.is_up_tapped():
		done.emit(chest_state_machine.chest_open_state)
