class_name TitleScreen
extends Control


func _ready() -> void:
	PageRouter.show_page(PageNameConstants.LOAD_MENU_PAGE)
