class_name VillageEntrance
extends Room
# The very first room ever that players spawn in on new game

@onready var camera: Camera = $Camera
@onready var door: Door = $Door


# Called after parent ready
func _kid_ready() -> void:
	door.target_room_scene_path = SceneFilePathContants.VILLAGE_RIVER_BANK_SCENE_PATH
	camera.set_target(player)
	# TODO: Read local world state, then decide to play intro cutscene or not
