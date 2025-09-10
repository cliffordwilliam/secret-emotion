# Autoload PageRouter
extends CanvasLayer

@onready var current_page: Page = $BlankPage


func _ready() -> void:
	show_page(PageNameConstants.BLANK_PAGE)


func show_page(page_name: String) -> void:
	get_tree().paused = page_name != PageNameConstants.BLANK_PAGE
	current_page.on_close()
	current_page.hide()
	current_page = get_node(page_name)
	current_page.on_open()
	current_page.show()
