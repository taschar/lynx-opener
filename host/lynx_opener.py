#!/usr/bin/env python3
import sys
import json
import struct
import subprocess
import os

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

def open_lynx(url, terminal):
    try:
        # Different terminals use different flags to execute commands.
        # We try to accommodate the most common patterns.
        
        if terminal == 'gnome-terminal':
            cmd = [terminal, '--', 'lynx', url]
        elif terminal == 'konsole':
            cmd = [terminal, '-e', 'lynx', url]
        elif terminal == 'xfce4-terminal':
            cmd = [terminal, '-e', f'lynx {url}']
        elif terminal == 'kitty':
            cmd = [terminal, 'lynx', url]
        else:
            # Default fallback (works for xterm, alacritty, x-terminal-emulator)
            cmd = [terminal, '-e', 'lynx', url]

        # Use subprocess.Popen to avoid blocking
        subprocess.Popen(cmd, start_new_session=True)
        return {"status": "success", "message": f"Launched {terminal} with lynx"}
    except Exception as e:
        return {"status": "error", "message": str(e)}

def main():
    while True:
        try:
            message = get_message()
            url = message.get('url')
            terminal = message.get('terminal', 'x-terminal-emulator')
            
            if url:
                response = open_lynx(url, terminal)
                send_message(json.dumps(response))
        except EOFError:
            break
        except Exception as e:
            send_message(json.dumps({"status": "error", "message": str(e)}))
            break

if __name__ == '__main__':
    main()
