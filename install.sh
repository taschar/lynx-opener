#!/bin/bash

# Lynx Opener - Native Messaging Host Installation Script

HOST_NAME="com.lynx.opener"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PYTHON_SCRIPT="$SCRIPT_DIR/host/lynx_opener.py"
JSON_HOST_FILE_CHROME="$SCRIPT_DIR/host/$HOST_NAME.json"
JSON_HOST_FILE_FIREFOX="$SCRIPT_DIR/host/${HOST_NAME}_firefox.json"

echo "=== Lynx Opener Installation ==="

# 1. Make the python script executable
chmod +x "$PYTHON_SCRIPT"

# 2. Get Extension ID from user (for Chrome-based)
echo "Please enter your Extension ID (required for Chrome/Brave/Edge)."
echo "(Found in chrome://extensions after loading the unpacked extension)"
read -p "Chrome Extension ID (leave empty to skip Chrome installation): " EXT_ID

# 3. Create JSON host file for Chrome-based browsers
if [ -n "$EXT_ID" ]; then
    cat > "$JSON_HOST_FILE_CHROME" << EOF
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
        cp "$JSON_HOST_FILE_CHROME" "$DIR/$HOST_NAME.json"
        echo "Installed for Chromium-based: $DIR"
    done
fi

# 4. Install for Firefox
echo ""
echo "Installing for Firefox..."
FIREFOX_ID="lynx-opener@tasos.dev"

cat > "$JSON_HOST_FILE_FIREFOX" << EOF
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
    cp "$JSON_HOST_FILE_FIREFOX" "$DIR/$HOST_NAME.json"
    echo "Installed for Firefox: $DIR"
done

echo ""
echo "=== Installation Complete ==="
echo "Note: Make sure 'lynx' and your preferred terminal are installed on your system."
echo "If using Firefox, make sure to load the extension via 'about:debugging'."
