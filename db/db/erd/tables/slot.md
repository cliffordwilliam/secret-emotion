# Slots Table

## Description

Represents player save slots. Each slot acts as a save file or profile namespace.
Only one slot can be active at a time, but multiple slots can exist for different playthroughs.

## Columns

| column              | Type    | constraints                        | Description                                                           |
| ------------------- | ------- | ---------------------------------- | --------------------------------------------------------------------- |
| id                  | INTEGER | PRIMARY KEY AUTOINCREMENT          | Unique identifier for the save slot                                   |
| label               | TEXT    | NOT NULL UNIQUE                    | User-facing label for the slot (e.g., "Save 1", "My First Run")       |
| is_active           | INTEGER | NOT NULL DEFAULT 0                 | Indicates if this slot is currently active (0 = inactive, 1 = active) |
| last_played_at      | TEXT    |                                    | Timestamp of the last time the slot was loaded or saved               |
| play_time_seconds   | INTEGER | DEFAULT 0                          | Accumulated play time in seconds                                      |
| screenshot_path     | TEXT    |                                    | Path to a screenshot thumbnail associated with this save slot         |
| metadata            | TEXT    |                                    | JSON blob for flexible extra info (e.g., level, location, chapter)    |
| created_at          | TEXT    | NOT NULL DEFAULT (datetime('now')) | Record creation timestamp                                             |
| updated_at          | TEXT    | NOT NULL DEFAULT (datetime('now')) | Last modification timestamp                                           |

## SQL Schema

```sql
CREATE TABLE IF NOT EXISTS slots (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	label TEXT NOT NULL UNIQUE,
	is_active INTEGER NOT NULL DEFAULT 0,
	last_played_at TEXT,
	play_time_seconds INTEGER DEFAULT 0,
	screenshot_path TEXT,
	metadata TEXT,
	created_at TEXT NOT NULL DEFAULT (datetime('now')),
	updated_at TEXT NOT NULL DEFAULT (datetime('now'))
);
```
