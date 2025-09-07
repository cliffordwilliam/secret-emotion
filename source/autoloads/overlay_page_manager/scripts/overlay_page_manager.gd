#class_name OverlayPageManager
# This is an autoload class OverlayPageManager
extends CanvasLayer
# There must always be only 1 current overlay page all the time
# Exposes change page public API for anyone to use

var overlay_blank_page: PackedScene = preload(SceneFilePathContants.OVERLAY_BLANK_SCENE_PATH)

@onready var current_overlay_page: OverlayPage = overlay_blank_page.instantiate()


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	self.add_child(current_overlay_page)


func change_page(new_overlay_page_scene_path: String) -> void:
	# TODO: If given path is invalid then just return, ignore request
	await get_tree().process_frame
	current_overlay_page.exit()
	var previous_overlay_page: OverlayPage = current_overlay_page
	current_overlay_page = load(new_overlay_page_scene_path).instantiate()
	self.add_child(current_overlay_page)
	current_overlay_page.enter()
	previous_overlay_page.free()
	# Do not pause if current page is now blank page
	get_tree().paused = not current_overlay_page is OverlayBlankPage
