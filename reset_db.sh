#!/bin/bash

# Path to the database
DB_PATH="$HOME/.local/share/godot/app_userdata/Secret Emotion/save_backup.json"

# Check if the file exists
if [ -f "$DB_PATH" ]; then
    echo "Deleting existing database: $DB_PATH"
    rm "$DB_PATH"
    echo "Database deleted."
else
    echo "No database found at $DB_PATH. Nothing to delete."
fi
