class_name VillageEntrance
extends Room
# Where player first start, meeting friend

@onready var camera: Camera = $Camera


func _kid_ready() -> void:
	# Called after parent ready
	camera.set_target(player)
	# TODO: Read local world state, then decide to play intro cutscene or not
