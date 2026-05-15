#!/usr/bin/env python3
import sys
import json
import struct
import subprocess
import os
import platform

# Helper function that sends a message to the extension.
def send_message(message):
    # Write message size.
    sys.stdout.buffer.write(struct.pack('I', len(message)))
    # Write the message itself.
    sys.stdout.buffer.write(message.encode('utf-8'))
    sys.stdout.buffer.flush()

# Helper function to read a message from the extension.
def get_message():
    raw_length = sys.stdin.buffer.read(4)
    if not raw_length:
        sys.exit(0)
    message_length = struct.unpack('I', raw_length)[0]
    message = sys.stdin.buffer.read(message_length).decode('utf-8')
    return json.loads(message)

def open_lynx(url, terminal, fullscreen):
    system = platform.system()
    try:
        if system == "Linux":
            if terminal == 'gnome-terminal':
                cmd = [terminal]
                if fullscreen: cmd.append('--full-screen')
                cmd.extend(['--', 'lynx', url])
            elif terminal == 'konsole':
                cmd = [terminal]
                if fullscreen: cmd.append('--fullscreen')
                cmd.extend(['-e', 'lynx', url])
            elif terminal == 'xfce4-terminal':
                cmd = [terminal]
                if fullscreen: cmd.append('--fullscreen')
                cmd.extend(['--command', f'lynx "{url}"'])
            elif terminal == 'xterm':
                cmd = [terminal]
                if fullscreen: cmd.append('-fullscreen')
                cmd.extend(['-e', 'lynx', url])
            elif terminal == 'kitty':
                cmd = [terminal]
                if fullscreen: cmd.append('--start-as=fullscreen')
                cmd.extend(['lynx', url])
            elif terminal == 'alacritty':
                cmd = [terminal]
                if fullscreen: cmd.extend(['--option', 'window.startup_mode=Fullscreen'])
                cmd.extend(['-e', 'lynx', url])
            else:
                # Default Linux fallback
                cmd = [terminal if terminal != 'x-terminal-emulator' else 'x-terminal-emulator', '-e', 'lynx', url]
        
        elif system == "Darwin":  # macOS
            if terminal == "iTerm":
                # iTerm2 specific logic could go here
                cmd = ["open", "-a", "iTerm", f"lynx '{url}'"]
            else:
                # Default Terminal.app
                if fullscreen:
                    # Use AppleScript to toggle fullscreen after opening
                    applescript = f'tell application "Terminal" to do script "lynx \'{url}\'"; activate; tell application "System Events" to keystroke "f" using {{control down, command down}}'
                    cmd = ["osascript", "-e", applescript]
                else:
                    cmd = ["open", "-a", "Terminal", f"lynx '{url}'"]
        
        elif system == "Windows":
            if terminal == "wt": # Windows Terminal
                cmd = ["wt"]
                if fullscreen: cmd.append("-f")
                cmd.extend(["lynx", url])
            else:
                # Use 'start' via cmd to launch in a new window
                # Windows doesn't easily support fullscreen via command line for cmd.exe
                cmd = ["cmd.exe", "/c", "start", "lynx", url]
        
        else:
            return {"status": "error", "message": f"Unsupported OS: {system}"}

        subprocess.Popen(cmd, start_new_session=True)
        return {"status": "success", "message": f"Launched on {system} (Terminal: {terminal}, Fullscreen: {fullscreen})"}
    except Exception as e:
        return {"status": "error", "message": str(e)}

def main():
    while True:
        try:
            message = get_message()
            url = message.get('url')
            # Detect system to set appropriate default terminal
            system = platform.system()
            default_terminal = 'x-terminal-emulator'
            if system == 'Darwin': default_terminal = 'Terminal'
            if system == 'Windows': default_terminal = 'cmd'
            
            terminal = message.get('terminal', default_terminal)
            fullscreen = message.get('fullscreen', True)
            
            if url:
                response = open_lynx(url, terminal, fullscreen)
                send_message(json.dumps(response))
        except EOFError:
            break
        except Exception as e:
            send_message(json.dumps({"status": "error", "message": str(e)}))
            break

if __name__ == '__main__':
    main()
