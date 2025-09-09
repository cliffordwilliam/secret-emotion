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
			date_created TEXT NOT NULL DEFAULT (datetime('now')),
			date_modified TEXT NOT NULL DEFAULT (datetime('now'))
		);
		""",
		"""
		CREATE INDEX IF NOT EXISTS idx_slots_name ON slots(slot_name);
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
			room_name TEXT NOT NULL,
			active_status INTEGER NOT NULL DEFAULT 0,
			scene_file_path TEXT NOT NULL,
			date_created TEXT NOT NULL DEFAULT (datetime('now')),
			date_modified TEXT NOT NULL DEFAULT (datetime('now')),
			FOREIGN KEY(slot_id) REFERENCES slots(slot_id) ON DELETE CASCADE
			UNIQUE(slot_id, room_name)
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
		""",
		# CHESTS TABLE
		"""
		CREATE TABLE IF NOT EXISTS chests (
			chest_id INTEGER PRIMARY KEY AUTOINCREMENT,
			slot_id INTEGER NOT NULL,
			room_id INTEGER NOT NULL,
			chest_name TEXT NOT NULL,
			current_state TEXT NOT NULL,
			date_created TEXT NOT NULL DEFAULT (datetime('now')),
			date_modified TEXT NOT NULL DEFAULT (datetime('now')),
			FOREIGN KEY(room_id) REFERENCES rooms(room_id) ON DELETE CASCADE,
			UNIQUE(slot_id, room_id, chest_name)
		);
		""",
		"""
		CREATE INDEX IF NOT EXISTS idx_chests_room_id ON chests(room_id);
		""",
		"""
		CREATE TRIGGER IF NOT EXISTS update_chests_modtime
		AFTER UPDATE ON chests
		FOR EACH ROW
		BEGIN
			UPDATE chests SET date_modified = datetime('now') WHERE chest_id = OLD.chest_id;
		END;
		""",
		# PLAYER TABLE
		"""
		CREATE TABLE IF NOT EXISTS player (
			player_id INTEGER PRIMARY KEY AUTOINCREMENT,
			slot_id INTEGER NOT NULL,
			pos_x REAL NOT NULL DEFAULT 0.0,
			pos_y REAL NOT NULL DEFAULT 0.0,
			flip_h INTEGER NOT NULL DEFAULT 0,
			date_created TEXT NOT NULL DEFAULT (datetime('now')),
			date_modified TEXT NOT NULL DEFAULT (datetime('now')),
			FOREIGN KEY(slot_id) REFERENCES slots(slot_id) ON DELETE CASCADE
		);
		""",
		"""
		CREATE INDEX IF NOT EXISTS idx_player_slot_id ON player(slot_id);
		""",
		"""
		CREATE TRIGGER IF NOT EXISTS update_player_modtime
		AFTER UPDATE ON player
		FOR EACH ROW
		BEGIN
			UPDATE player SET date_modified = datetime('now') WHERE player_id = OLD.player_id;
		END;
		""",
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
