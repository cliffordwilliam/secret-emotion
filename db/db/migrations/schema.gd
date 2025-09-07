class_name Schema
extends RefCounted
# Holds db migration


static func migrate(database: SQLite) -> void:
	print("Running database migrations...")

	var sql_commands: Array[String] = [
		# SLOTS TABLE
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
		""",
		"""
		CREATE INDEX IF NOT EXISTS idx_slots_name ON slots(slot_name);
		""",
		"""
		CREATE INDEX IF NOT EXISTS idx_slots_last_played ON slots(last_played_at);
		""",
		"""
		CREATE TRIGGER IF NOT EXISTS update_slots_modtime
		AFTER UPDATE ON slots
		FOR EACH ROW
		BEGIN
			UPDATE slots SET date_modified = datetime('now') WHERE slot_id = OLD.slot_id;
		END;
		""",
		# ROOMS TABLE
		"""
		CREATE TABLE IF NOT EXISTS rooms (
			room_id INTEGER PRIMARY KEY AUTOINCREMENT,
			slot_id INTEGER NOT NULL,
			room_name TEXT NOT NULL UNIQUE,
			current_room INTEGER NOT NULL DEFAULT 0,
			date_created TEXT NOT NULL DEFAULT (datetime('now')),
			date_modified TEXT NOT NULL DEFAULT (datetime('now')),
			FOREIGN KEY(slot_id) REFERENCES slots(slot_id) ON DELETE CASCADE
		);
		""",
		"""
		CREATE INDEX IF NOT EXISTS idx_rooms_name ON rooms(room_name);
		""",
		"""
		CREATE INDEX IF NOT EXISTS idx_rooms_slot_id ON rooms(slot_id);
		""",
		"""
		CREATE TRIGGER IF NOT EXISTS update_rooms_modtime
		AFTER UPDATE ON rooms
		FOR EACH ROW
		BEGIN
			UPDATE rooms SET date_modified = datetime('now') WHERE room_id = OLD.room_id;
		END;
		"""
	]

	for sql_command: String in sql_commands:
		_exec(database, sql_command)

	print("Database migrations successful!")


static func _exec(database: SQLite, sql_command: String) -> void:
	if not database.query(sql_command):
		_error(database.error_message)


static func _error(error_message: String) -> void:
	# TODO: Can activate global error boundary
	push_error("Migration failed: " + error_message)
