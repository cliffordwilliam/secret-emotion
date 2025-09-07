# Rooms Table

## Description

Represents individual rooms within a Metroidvania game.
Each room belongs to a specific save slot and can be marked as the currently active room within that slot.

## Columns

| column        | Type    | constraints                        | Description                                                                        |
| ------------- | ------- | ---------------------------------- | ---------------------------------------------------------------------------------- |
| id            | INTEGER | PRIMARY KEY AUTOINCREMENT          | Unique identifier for the room                                                     |
| slot\_id      | INTEGER | NOT NULL, FOREIGN KEY -> slots(id) | Reference to the save slot this room belongs to                                    |
| name          | TEXT    | NOT NULL                           | Human-readable name of the room                                                    |
| current\_room | INTEGER | NOT NULL DEFAULT 0                 | Indicates if this room is the currently active room for its slot (0 = no, 1 = yes) |
| created\_at   | TEXT    | NOT NULL DEFAULT (datetime('now')) | Record creation timestamp                                                          |
| updated\_at   | TEXT    | NOT NULL DEFAULT (datetime('now')) | Last modification timestamp                                                        |

## SQL Schema

```sql
CREATE TABLE IF NOT EXISTS rooms (
	id INTEGER PRIMARY KEY AUTOINCREMENT,
	slot_id INTEGER NOT NULL,
	name TEXT NOT NULL,
	current_room INTEGER NOT NULL DEFAULT 0,
	created_at TEXT NOT NULL DEFAULT (datetime('now')),
	updated_at TEXT NOT NULL DEFAULT (datetime('now')),
	FOREIGN KEY(slot_id) REFERENCES slots(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_rooms_name ON rooms(name);
CREATE INDEX IF NOT EXISTS idx_rooms_slot_id ON rooms(slot_id);
```
