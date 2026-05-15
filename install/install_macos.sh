#!/bin/bash

# Lynx Opener - macOS Installation Script

HOST_NAME="com.lynx.opener"
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_DIR="$( dirname "$SCRIPT_DIR" )"
PYTHON_SCRIPT="$PROJECT_DIR/host/lynx_opener.py"

echo "=== Lynx Opener macOS Installation ==="

# 1. Make the python script executable
chmod +x "$PYTHON_SCRIPT"

# 2. Get Extension ID
read -p "Chrome Extension ID (leave empty to skip Chrome installation): " EXT_ID

# 3. Create JSON host file for Chrome-based browsers
if [ -n "$EXT_ID" ]; then
    MANIFEST_PATH="$PROJECT_DIR/host/macos/$HOST_NAME.json"
    sed -e "s|HOST_PATH|$PYTHON_SCRIPT|g" \
        -e "s|EXTENSION_ID|$EXT_ID|g" \
        "$PROJECT_DIR/host/macos/com.lynx.opener.json" > "$MANIFEST_PATH"

    CHROME_DIRS=(
        "$HOME/Library/Application Support/Google/Chrome/NativeMessagingHosts"
        "$HOME/Library/Application Support/Chromium/NativeMessagingHosts"
        "$HOME/Library/Application Support/BraveSoftware/Brave-Browser/NativeMessagingHosts"
        "$HOME/Library/Application Support/Microsoft Edge/NativeMessagingHosts"
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
FIREFOX_MANIFEST_PATH="$PROJECT_DIR/host/macos/${HOST_NAME}_firefox.json"
sed -e "s|HOST_PATH|$PYTHON_SCRIPT|g" \
    "$PROJECT_DIR/host/macos/com.lynx.opener_firefox.json" > "$FIREFOX_MANIFEST_PATH"

FIREFOX_DIRS=(
    "$HOME/Library/Application Support/Mozilla/NativeMessagingHosts"
)

for DIR in "${FIREFOX_DIRS[@]}"; do
    mkdir -p "$DIR"
    cp "$FIREFOX_MANIFEST_PATH" "$DIR/$HOST_NAME.json"
    echo "Installed for Firefox: $DIR"
done

echo ""
echo "=== Installation Complete ==="
echo "Note: Make sure 'lynx' is installed (e.g., via 'brew install lynx')."
