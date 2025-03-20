#!/usr/bin/env bash

# Extract the board name from platformio.ini
BOARD_NAME=$(grep -E '^board\s*=\s*' platformio.ini | awk -F= '{print $2}' | tr -d '[:space:]')

# Debug: Print the extracted board name
echo "Extracted board name: '$BOARD_NAME'"

# Check if the board name was found
if [ -z "$BOARD_NAME" ]; then
  echo "Board name not found in platformio.ini."
  exit 1
fi

# Check for .pio/libdeps/BOARD_NAME directory and include paths if they exist
LIBDEPS_DIR=".pio/libdeps/$BOARD_NAME"
if [ -d "$LIBDEPS_DIR" ]; then
  echo "Updating .clangd with include paths from $LIBDEPS_DIR..."

  # Collect only the subdirectory include paths (excluding the parent directory)
  INCLUDE_PATHS=$(find "$LIBDEPS_DIR" -mindepth 1 -maxdepth 1 -type d -exec echo "      -I{}," \;)

  # Debug: Print the include paths
  echo "Include paths found:"
  echo "$INCLUDE_PATHS"

  # Add the paths to the existing .clangd file, just before the closing bracket of Add:
  awk -v include_paths="$INCLUDE_PATHS" '
  /Add:/ {
      print
      in_add_section = 1
      next
  }
  in_add_section && /^\s*\]/ {
      print include_paths
      in_add_section = 0
  }
  1' .clangd > .clangd.tmp && mv .clangd.tmp .clangd

  echo ".clangd updated successfully."
else
  echo "Directory $LIBDEPS_DIR does not exist."
fi
