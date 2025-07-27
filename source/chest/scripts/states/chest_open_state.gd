class_name ChestOpenState
extends ChestState
# Chest opened


func enter(_previous_state: State) -> void:
	chest.play_animation.emit(chest_animation_name_data.OPEN)


func physics_process(_delta: float) -> void:
	if chest_input.is_up_tapped():
		done.emit(chest_state_machine.chest_close_state)
