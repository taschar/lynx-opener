#!/bin/bash

# Lynx Opener - Universal Installer Dispatcher

OS_TYPE="$(uname)"

case "$OS_TYPE" in
    "Linux")
        echo "Detected Linux."
        chmod +x install/install_linux.sh
        ./install/install_linux.sh
        ;;
    "Darwin")
        echo "Detected macOS."
        chmod +x install/install_macos.sh
        ./install/install_macos.sh
        ;;
    "MINGW"*|"MSYS"*|"CYGWIN"*)
        echo "Detected Windows environment."
        echo "Please run 'powershell ./install/install_windows.ps1' from a PowerShell terminal."
        ;;
    *)
        echo "Unsupported OS: $OS_TYPE"
        exit 1
        ;;
esac
