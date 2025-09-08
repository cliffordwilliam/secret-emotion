# Chests Table

## Description

Represents interactive chests within a room.
Each chest belongs to a specific room and stores its current state.
The database does not validate state values; instead, individual chest logic enforces allowed states at runtime.
This allows flexibility for future chest behaviors while keeping the schema minimal.

## Columns

| column       | Type    | constraints                        | Description                                                                 |
| ------------ | ------- | ---------------------------------- | --------------------------------------------------------------------------- |
| id           | INTEGER | PRIMARY KEY AUTOINCREMENT          | Unique identifier for the chest                                             |
| room_id      | INTEGER | NOT NULL, FOREIGN KEY -> rooms(id) | Reference to the room this chest belongs to                                 |
| chest_name   | TEXT    | NOT NULL                           | Unique identifier for the chest within its room (e.g., `"chest_near_door"`) |
| state        | TEXT    | NOT NULL DEFAULT `'closed'`        | Current state of the chest (`closed`, `open`, `locked`, etc.)               |
| created_at   | TEXT    | NOT NULL DEFAULT (datetime('now')) | Record creation timestamp                                                   |
| updated_at   | TEXT    | NOT NULL DEFAULT (datetime('now')) | Last modification timestamp                                                 |

## SQL Schema

```sql
CREATE TABLE IF NOT EXISTS chests (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	room_id INTEGER NOT NULL,
	chest_name TEXT NOT NULL,
	state TEXT NOT NULL DEFAULT 'closed',
	created_at TEXT NOT NULL DEFAULT (datetime('now')),
	updated_at TEXT NOT NULL DEFAULT (datetime('now')),
	FOREIGN KEY(room_id) REFERENCES rooms(id) ON DELETE CASCADE,
	UNIQUE(room_id, chest_name)
);

CREATE INDEX IF NOT EXISTS idx_chests_room_id ON chests(room_id);
```
