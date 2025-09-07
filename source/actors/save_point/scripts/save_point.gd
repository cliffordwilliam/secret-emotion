@icon("res://source/actors/save_point/assets/flag.svg")
class_name SavePoint
extends Area2D
# Responsible for activating save menu scene in game world

# TODO: No need, instead make a page manager
# TODO: This thing will request a save page from it
# TODO: Each page in page manager should run during pause
# TODO: Page manager will pause the game when 1 page is shown
# TODO: There will always be 1 page at a time always
# TODO: The nothing page does nothing and does not pause the game
# TODO: When you press save in the page manager page, each page should have signal to emit
# TODO: Page manager owner should listen to each kid emit signal
# TODO: Then room should listen to any signal that the page manager has as needed
# TODO: So here room listen to page mananger requesting all item in scene that are savable to dump
signal player_pressed_save_button

@onready var save_point_input: PlayerInput = $PlayerInput
@onready var save_point_animated_sprite: SavePointAnimatedSprite = $SavePointAnimatedSprite
@onready var interaction_marker: InteractionMarker = $InteractionMarker
#@onready var save_menu: CenterContainer = $CanvasLayer/SaveMenu


func _ready() -> void:
	save_point_input.disable_input()
	#save_menu.player_pressed_save_button.connect(_on_save_menu_player_pressed_save_button)
	save_point_animated_sprite.play(SavePointAnimationNameData.SPIN)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _physics_process(_delta: float) -> void:
	if save_point_input.is_up_tapped():
		return
		#get_tree().paused = true
		#save_menu.show()
		# Save menu will unhide and unpause


func _on_body_entered(_body: Node2D) -> void:
	save_point_input.enable_input()
	interaction_marker.set_active()


func _on_body_exited(_body: Node2D) -> void:
	save_point_input.disable_input()
	interaction_marker.set_inactive()


func _on_save_menu_player_pressed_save_button() -> void:
	player_pressed_save_button.emit()
