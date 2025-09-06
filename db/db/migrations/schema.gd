class_name Schema
extends RefCounted
# Holds db migration


static func migrate(database: SQLite) -> void:
	print("Running database migrations...")

	# Slots table (acts as save file / tenant / namespace)
	(
		database
		. query(
			"""
		CREATE TABLE IF NOT EXISTS slots (
			id INTEGER PRIMARY KEY AUTOINCREMENT,
			label TEXT NOT NULL UNIQUE,
			is_active INTEGER NOT NULL DEFAULT 0,
			last_played_at TEXT,
			play_time_seconds INTEGER DEFAULT 0,
			created_at TEXT NOT NULL DEFAULT (datetime('now')),
			updated_at TEXT NOT NULL DEFAULT (datetime('now'))
		);
	"""
		)
	)
