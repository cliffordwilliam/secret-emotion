#!/bin/bash
set -euo pipefail

ROOT_DIR="source"

failed=0

# If pre-commit passes files as args, use them; otherwise scan whole project
if [[ $# -gt 0 ]]; then
    files=("$@")
else
    mapfile -t files < <(find "$ROOT_DIR" -type f -name "*.tscn")
fi

for file in "${files[@]}"; do
    [[ $file != *.tscn ]] && continue  # ignore non-TSCN files

    filename=$(basename "$file")

    # Check PascalCase pattern: must start with uppercase, then only alphanumeric
    if [[ ! $filename =~ ^[A-Z][A-Za-z0-9]*\.tscn$ ]]; then
        echo "❌ Scene naming error in $file"
        echo "   Expected PascalCase, e.g. MainMenu.tscn"
        echo "   Found: $filename"
        failed=1
    fi
done

if [[ $failed -eq 1 ]]; then
    echo ""
    echo "Commit aborted due to invalid .tscn file naming conventions."
    exit 1
fi
