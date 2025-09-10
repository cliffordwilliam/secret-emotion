class_name TitleScreen
extends Control


func _ready() -> void:
	# TODO: Show game logo, on press go to main menu
	PageRouter.show_page(PageNameConstants.LOAD_MENU_PAGE)
