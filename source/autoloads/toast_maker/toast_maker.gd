# This is an autoload class (ToastMaker)
extends CanvasLayer

# Reference to the container node
# The toast scene
var ToastScene: PackedScene = preload("res://source/shared/ui_components/toast/UiToast.tscn")


func _ready() -> void:
	layer = 2


# Add a new toast
func show_toast(text: String) -> void:
	var toast: UiToast = ToastScene.instantiate()
	self.add_child(toast)
	toast.set_text(text)
	_push_down_existing(toast)
	toast.start_timer()


# Push down existing toasts so new one is on top
func _push_down_existing(new_toast: Node) -> void:
	for toast: UiToast in self.get_children():
		if toast != new_toast:
			toast.position.y += toast.size.y
