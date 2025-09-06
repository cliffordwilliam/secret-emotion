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
			slot_id INTEGER PRIMARY KEY AUTOINCREMENT,
			slot_name TEXT NOT NULL UNIQUE,
			active_status INTEGER NOT NULL DEFAULT 0,
			last_played_at TEXT,
			play_time_seconds INTEGER DEFAULT 0,
			date_created TEXT NOT NULL DEFAULT (datetime('now')),
			date_modified TEXT NOT NULL DEFAULT (datetime('now'))
		);
	"""
		)
	)
