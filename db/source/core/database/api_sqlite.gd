# This is an autoload class (ApiSqlite)
extends Node
# Instance db client + run migration (create if db and table do not exists)

var database: SQLite


func _ready() -> void:
	_open_database()
	_apply_pragmas()
	_import_disk_json_to_mem()


func _open_database() -> void:
	database = SQLite.new()
	database.path = ApiDatabaseConfig.DB_PATH
	database.verbosity_level = ApiDatabaseConfig.VERBOSITY_LEVEL
	if not database.open_db():
		# TODO: Can activate global error boundary
		push_error("Failed to open database at %s" % ApiDatabaseConfig.DB_PATH)
		get_tree().quit(1)
		return


func _apply_pragmas() -> void:
	for pragma_key: String in ApiDatabaseConfig.PRAGMAS.keys():
		var value: String = ApiDatabaseConfig.PRAGMAS[pragma_key]
		var sql: String = "PRAGMA %s = %s;" % [pragma_key, str(value).to_lower()]
		if not database.query(sql):
			# TODO: Can activate global error boundary
			push_error("Failed to apply PRAGMA:", pragma_key, "with value:", value)
			get_tree().quit(1)
			return


func _run_migrations() -> void:
	Schema.migrate(database)


func dump_mem_to_disk_json() -> void:
	# Make sure the db is open
	if not ApiSqlite.database:
		push_error("No active SQLite database to dump")
		return

	var backup_path: String = "user://save_backup.json"
	var success: bool = ApiSqlite.database.export_to_json(backup_path)

	if success:
		print("Database successfully dumped to disk at: %s" % backup_path)
	else:
		push_error("Failed to dump database to disk: %s" % ApiSqlite.database.error_message)


func _import_disk_json_to_mem() -> void:
	# TODO: Move this to a ref count please
	var backup_path: String = "user://save_backup.json"
	_sanitize_backup_json(backup_path)

	# Make sure the file exists
	if not FileAccess.file_exists(backup_path):
		_run_migrations()
		print("Backup file not found at: %s" % backup_path)
		return

	# Open the database if not already
	if not ApiSqlite.database:
		push_error("No active SQLite database to import into")
		return

	var success: bool = ApiSqlite.database.import_from_json(backup_path)

	if success:
		print("Database successfully imported from disk: %s" % backup_path)
	else:
		push_error("Failed to import database: %s" % ApiSqlite.database.error_message)


func _sanitize_backup_json(backup_path: String) -> void:
	if not FileAccess.file_exists(backup_path):
		print("Backup file not found at: %s" % backup_path)
		return

	# Read JSON from disk
	var file: FileAccess = FileAccess.open(backup_path, FileAccess.READ)
	if not file:
		push_error("Failed to open backup file: %s" % backup_path)
		return
	var json_text: String = file.get_as_text()
	file.close()

	var json_result: Variant = JSON.parse_string(json_text)
	if json_result == null:
		push_error("Failed to parse JSON: %s" % json_result.error_string)
		return

	var data_array: Array = json_result
	var sanitized_array: Array[Dictionary] = []

	# Filter out internal tables / indexes
	for entry: Dictionary in data_array:
		var found_name: String = entry.get("name", "")
		if found_name == "sqlite_sequence" or found_name.begins_with("sqlite_autoindex"):
			continue
		sanitized_array.append(entry)

	# Write sanitized JSON back to disk
	file = FileAccess.open(backup_path, FileAccess.WRITE)
	if not file:
		push_error("Failed to write sanitized backup file: %s" % backup_path)
		return
	file.store_string(JSON.stringify(sanitized_array))
	file.close()

	print("Backup JSON sanitized successfully: %s" % backup_path)
