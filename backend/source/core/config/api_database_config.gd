class_name ApiDatabaseConfig
extends RefCounted
# Holds db configs

# Use SQLite in-memory mode
const DB_PATH: StringName = ":memory:"

const VERBOSITY_LEVEL: SQLite.VerbosityLevel = SQLite.QUIET

const PRAGMAS: Dictionary[String, String] = {
	"foreign_keys": "true", "journal_mode": "wal", "synchronous": "normal"
}
