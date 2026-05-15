#!/bin/bash

# Lynx Opener - Linux Installation Script

HOST_NAME="com.lynx.opener"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_DIR="$( dirname "$SCRIPT_DIR" )"
PYTHON_SCRIPT="$PROJECT_DIR/host/lynx_opener.py"

echo "=== Lynx Opener Linux Installation ==="

# 1. Make the python script executable
chmod +x "$PYTHON_SCRIPT"

# 2. Get Extension ID
read -p "Chrome Extension ID (leave empty to skip Chrome installation): " EXT_ID

# 3. Create JSON host file for Chrome-based browsers
if [ -n "$EXT_ID" ]; then
    MANIFEST_PATH="$PROJECT_DIR/host/linux/$HOST_NAME.json"
    cat > "$MANIFEST_PATH" << EOF
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

    CHROME_DIRS=(
        "$HOME/.config/google-chrome/NativeMessagingHosts"
        "$HOME/.config/chromium/NativeMessagingHosts"
        "$HOME/.config/BraveSoftware/Brave-Browser/NativeMessagingHosts"
        "$HOME/.config/microsoft-edge/NativeMessagingHosts"
    )

    for DIR in "${CHROME_DIRS[@]}"; do
        mkdir -p "$DIR"
        cp "$MANIFEST_PATH" "$DIR/$HOST_NAME.json"
        echo "Installed for Chromium-based: $DIR"
    done
fi

# 4. Install for Firefox
echo ""
echo "Installing for Firefox..."
FIREFOX_ID="lynx-opener@tasos.dev"
FIREFOX_MANIFEST_PATH="$PROJECT_DIR/host/linux/${HOST_NAME}_firefox.json"

cat > "$FIREFOX_MANIFEST_PATH" << EOF
{
  "name": "$HOST_NAME",
  "description": "Host for opening links in Lynx via terminal",
  "path": "$PYTHON_SCRIPT",
  "type": "stdio",
  "allowed_extensions": [
    "$FIREFOX_ID"
  ]
}
EOF

FIREFOX_DIRS=(
    "$HOME/.mozilla/native-messaging-hosts"
)

for DIR in "${FIREFOX_DIRS[@]}"; do
    mkdir -p "$DIR"
    cp "$FIREFOX_MANIFEST_PATH" "$DIR/$HOST_NAME.json"
    echo "Installed for Firefox: $DIR"
done

echo ""
echo "=== Installation Complete ==="
echo "Note: Make sure 'lynx' and your preferred terminal are installed."
