class_name ValidatedFilePath
extends Node
# Base class that have _validate_file_path func for Node kids to use
# Validates external engine values against codebase const (any file paths)


# TODO: Can activate global error boundary
func _validate_file_path(file_paths: Array[String]) -> void:
	for path: String in file_paths:
		if not FileAccess.file_exists(path):
			push_error("❌ Missing file: %s" % path)
			get_tree().quit(1)

	print("✅ All files exist.")
