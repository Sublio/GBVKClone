swiftlint_modified_files.sh

#!/bin/bash

# Get the list of modified and new files
FILES=$(git diff --name-only --diff-filter=d HEAD | grep '\.swift$')

# Run SwiftLint only on these files
if [ -n "$FILES" ]; then
    echo "Linting and fixing modified/new Swift files:"
    echo "$FILES"
    for FILE in $FILES; do
        swiftlint autocorrect --path "$FILE"
    done
else
    echo "No modified/new Swift files found."
fi
