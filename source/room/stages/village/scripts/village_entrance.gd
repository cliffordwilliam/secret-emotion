class_name VillageEntrance
extends Room
# The very first room ever that players spawn in on new game

@onready var camera: Camera = $Camera


# Called after parent ready
func _kid_ready() -> void:
	camera.set_target(player)
	# TODO: Read local world state, then decide to play intro cutscene or not
