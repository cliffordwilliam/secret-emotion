#!/usr/bin/env bash

find . -type f -name "*.gd" | while read -r file; do
    first_line=$(head -n 1 "$file")

    # Only process if the first line has class_name
    if [[ "$first_line" == class_name* ]]; then
        class_name=$(echo "$first_line" | awk '{print $2}')

        # Convert filename (without extension) from snake_case to PascalCase
        filename=$(basename "$file" .gd)
        expected_class=$(echo "$filename" | sed -r 's/(^|_)([a-z])/\U\2/g')

        if [[ "$class_name" != "$expected_class" ]]; then
            echo "Mismatch in $file → class_name=$class_name, expected=$expected_class"
        fi
    fi
done
