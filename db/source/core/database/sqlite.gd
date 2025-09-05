extends Node
# Instance db client + run migration (create if db and table if they do not exists)

var database: SQLite


func _ready() -> void:
	_open_database()
	_apply_pragmas()
	_run_migrations()


func _open_database() -> void:
	database = SQLite.new()
	database.path = DatabaseConfig.DB_PATH
	if not database.open_db():
		push_error("Failed to open database at %s" % DatabaseConfig.DB_PATH)
		get_tree().quit(1)
		return


func _apply_pragmas() -> void:
	for pragma_key in DatabaseConfig.PRAGMAS.keys():
		var value = DatabaseConfig.PRAGMAS[pragma_key]
		var sql = "PRAGMA %s = %s;" % [pragma_key, str(value).to_lower()]
		database.query(sql)


func _run_migrations() -> void:
	Schema.migrate(database)
