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

def open_lynx(url, terminal, fullscreen):
    try:
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
            # xfce4-terminal's -e takes a command string
            cmd.extend(['-e', f'lynx "{url}"'])
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
            cmd = [terminal, '-e', 'lynx', url]

        subprocess.Popen(cmd, start_new_session=True)
        return {"status": "success", "message": f"Launched {terminal} (Fullscreen: {fullscreen})"}
    except Exception as e:
        return {"status": "error", "message": str(e)}

def main():
    while True:
        try:
            message = get_message()
            url = message.get('url')
            terminal = message.get('terminal', 'x-terminal-emulator')
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
