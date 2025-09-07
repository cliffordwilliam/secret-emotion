# This is an autoload class (SceneFilePathContants)
extends ValidatedFilePath
# Validates external engine values against codebase const (.tscn file path)
# Why not ref counted? Because this needs _ready() to validate

# File paths needs String since its to be preloaded
const STAGES_BASE_SCENE_PATH: String = "res://source/room/stages/"
const VILLAGE_ENTRANCE_SCENE_PATH: String = (
	STAGES_BASE_SCENE_PATH + "village/scenes/VillageEntrance.tscn"
)
const VILLAGE_RIVER_BANK_SCENE_PATH: String = (
	STAGES_BASE_SCENE_PATH + "village/scenes/VillageRiverBank.tscn"
)

const UI_COMPONENT_BASE_SCENE_PATH: String = "res://source/shared/ui_components/"
const UI_LOAD_SLOT_ITEM_SCENE_PATH: String = (
	UI_COMPONENT_BASE_SCENE_PATH + "load_slot_item/scenes/UiLoadSlotItem.tscn"
)

const ALL_FILE_PATHS: Array[String] = [
	VILLAGE_ENTRANCE_SCENE_PATH,
	VILLAGE_RIVER_BANK_SCENE_PATH,
	UI_LOAD_SLOT_ITEM_SCENE_PATH,
]


func _ready() -> void:
	_validate_file_path(ALL_FILE_PATHS)
