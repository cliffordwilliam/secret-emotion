class_name VillageEntrance
extends Room
# Where player first start, meeting friend

@onready var camera: Camera = $Camera


func _ready() -> void:
	super._ready()
	camera.set_target(player)
	# TODO: Read local world state, then decide to play intro cutscene or not
