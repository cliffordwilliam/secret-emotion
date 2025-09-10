#!/bin/bash
set -euo pipefail

ROOT_DIR="source"

to_snake_case() {
    echo "$1" \
    | sed -E 's/([a-z0-9])([A-Z])/\1_\L\2/g' \
    | tr '[:upper:]' '[:lower:]'
}

failed=0

# If pre-commit passes files as args, use them; otherwise scan whole project
if [[ $# -gt 0 ]]; then
    files=("$@")
else
    mapfile -t files < <(find "$ROOT_DIR" -type f -name "*.gd")
fi

for file in "${files[@]}"; do
    [[ $file != *.gd ]] && continue  # ignore non-GD files

    # Get first 2 lines (in case first is @icon)
    first_line=$(head -n 1 "$file" | tr -d '\r')
    second_line=$(head -n 2 "$file" | tail -n 1 | tr -d '\r')

    # If @icon is present on line 1, use line 2 for validation
    if [[ $first_line =~ ^@icon ]]; then
        check_line="$second_line"
    else
        check_line="$first_line"
    fi

    if [[ $check_line =~ ^class_name[[:space:]]+([A-Za-z0-9_]+) ]]; then
        class_name="${BASH_REMATCH[1]}"
        expected_file="$(to_snake_case "$class_name").gd"
        actual_file="$(basename "$file")"

        if [[ "$expected_file" != "$actual_file" ]]; then
            echo "❌ File naming error in $file"
            echo "   Expected: $expected_file (from class_name $class_name)"
            echo "   Found:    $actual_file"
            failed=1
        fi

    elif [[ $check_line =~ ^\#\ Autoload ]]; then
        # Autoload scripts are allowed
        continue
    else
        echo "❌ Invalid first line in $file"
        echo "   Must start with either 'class_name' or '# Autoload ...'"
        echo "   Found: $check_line"
        failed=1
    fi
done

if [[ $failed -eq 1 ]]; then
    echo ""
    echo "Commit aborted due to Godot .gd file naming convention violations."
    exit 1
fi
