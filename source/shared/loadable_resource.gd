class_name LoadableResource
extends Resource
# Base class to save / load resource to disk (JSON)

# Use GUI to set disk path per kid resource
@export var disk_path: String = ""


# Called by owner on preload resource
func init() -> LoadableResource:
	_load_from_disk()
	return self


# Reads disk
func _load_from_disk() -> void:
	# TODO: Read disk here
	_apply_data()


# Disk -> props, signature for kids
func _apply_data() -> void:
	pass

# TODO: Save to disk
