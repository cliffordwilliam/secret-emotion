class_name UiToast
extends PanelContainer

const TOAST_DURATION: float = 10.0
var timer: Timer = Timer.new()
@onready var label: Label = $Label


func _ready() -> void:
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)


func set_text(value: String) -> void:
	label.text = value


# Start the timer
func start_timer() -> void:
	timer.start(TOAST_DURATION)


# Timer finished → free self
func _on_timer_timeout() -> void:
	queue_free()
