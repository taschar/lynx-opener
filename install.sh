#!/bin/bash

# Lynx Opener - Native Messaging Host Installation Script

HOST_NAME="com.lynx.opener"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PYTHON_SCRIPT="$SCRIPT_DIR/host/lynx_opener.py"
JSON_HOST_FILE="$SCRIPT_DIR/host/$HOST_NAME.json"

echo "=== Lynx Opener Installation ==="

# 1. Make the python script executable
chmod +x "$PYTHON_SCRIPT"

# 2. Get Extension ID from user
echo "Please enter your Chrome Extension ID."
echo "(You can find this in chrome://extensions after loading the unpacked extension)"
read -p "Extension ID: " EXT_ID

if [ -z "$EXT_ID" ]; then
    echo "Error: Extension ID is required."
    exit 1
fi

# 3. Create a temporary JSON host file with absolute paths and correct ID
cat > "$JSON_HOST_FILE" << EOF
{
  "name": "$HOST_NAME",
  "description": "Host for opening links in Lynx via terminal",
  "path": "$PYTHON_SCRIPT",
  "type": "stdio",
  "allowed_origins": [
    "chrome-extension://$EXT_ID/"
  ]
}
EOF

# 4. Install for various browsers
TARGET_DIRS=(
    "$HOME/.config/google-chrome/NativeMessagingHosts"
    "$HOME/.config/chromium/NativeMessagingHosts"
    "$HOME/.config/BraveSoftware/Brave-Browser/NativeMessagingHosts"
    "$HOME/.config/microsoft-edge/NativeMessagingHosts"
)

for DIR in "${TARGET_DIRS[@]}"; do
    mkdir -p "$DIR"
    cp "$JSON_HOST_FILE" "$DIR/$HOST_NAME.json"
    echo "Installed for: $DIR"
done

echo "=== Installation Complete ==="
echo "Note: Make sure 'lynx' and your preferred terminal are installed on your system."
