# This is an autoload class (ApiSqlite)
extends Node
# Instance db client + run migration (create if db and table do not exists)

var database: SQLite


func _ready() -> void:
	_open_database()
	_apply_pragmas()
	_run_migrations()


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
