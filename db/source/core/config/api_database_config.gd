class_name APIDatabaseConfig
extends RefCounted
# Holds db configs

const DB_PATH: StringName = "user://secret_emotion.db"

const PRAGMAS: Dictionary[String, String] = {
	"foreign_keys": "true", "journal_mode": "wal", "synchronous": "normal"
}
