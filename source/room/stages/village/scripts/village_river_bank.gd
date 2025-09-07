class_name VillageRiverBank
extends Room
# River bank beside village entrance

@onready var door: Door = $Door


# Called after parent ready
func _kid_ready() -> void:
	door.target_room_scene_path = SceneFilePathContants.VILLAGE_ENTRANCE_SCENE_PATH
