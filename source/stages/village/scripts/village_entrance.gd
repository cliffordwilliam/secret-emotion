class_name VillageEntrance
extends Room
# Where player first start, meeting friend

@onready var camera: Camera = $Camera


func _ready() -> void:
	super._ready()
	camera.set_target(player)
