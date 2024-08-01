#!/bin/bash

# Variables
SCRIPT_NAME="gilda.lua"
EXECUTABLE_NAME="gilda"
LOCAL_BIN_DIR="$HOME/.local/bin"

# Check if the script file exists
if [ ! -f "$SCRIPT_NAME" ]; then
    echo "Error: $SCRIPT_NAME not found."
    exit 1
fi

# Ensure the local bin directory exists
mkdir -p "$LOCAL_BIN_DIR"

# Create the executable script
cat <<EOF > "$LOCAL_BIN_DIR/$EXECUTABLE_NAME"
#!/bin/bash
lua $(realpath $SCRIPT_NAME) "\$@"
EOF

# Make the executable script executable
chmod +x "$LOCAL_BIN_DIR/$EXECUTABLE_NAME"

# Inform the user about adding to PATH if not already present
if ! echo "$PATH" | grep -q "$LOCAL_BIN_DIR"; then
    echo "To run 'gilda' from anywhere, add $LOCAL_BIN_DIR to your PATH:"
    echo "  export PATH=\"\$PATH:$LOCAL_BIN_DIR\""
    echo "You can add this line to your ~/.bashrc, ~/.zshrc, or ~/.profile file."
fi

echo "Installation complete. You can now use 'gilda <command>' from anywhere."
