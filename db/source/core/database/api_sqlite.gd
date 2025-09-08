# This is an autoload class (ApiSqlite)
extends Node
# Instance db client + run migration (create if db and table do not exists)

var database: SQLite


func _ready() -> void:
	_open_database()
	_apply_pragmas()
	_run_migrations()
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
	var backup_path: String = "user://save_backup.json"

	# Make sure the file exists
	if not FileAccess.file_exists(backup_path):
		push_error("Backup file not found at: %s" % backup_path)
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
