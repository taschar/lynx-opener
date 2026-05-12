// Saves options to chrome.storage
function save_options() {
  const terminal = document.getElementById('terminal').value;
  const fullscreen = document.getElementById('fullscreen').checked;
  chrome.storage.sync.set({
    terminal: terminal,
    fullscreen: fullscreen
  }, () => {
    // Update status to let user know options were saved.
    const status = document.getElementById('status');
    status.textContent = 'Settings saved!';
    setTimeout(() => {
      status.textContent = '';
    }, 2000);
  });
}

// Restores select box and checkbox state using the preferences
// stored in chrome.storage.
function restore_options() {
  chrome.storage.sync.get({
    terminal: 'x-terminal-emulator',
    fullscreen: true
  }, (items) => {
    document.getElementById('terminal').value = items.terminal;
    document.getElementById('fullscreen').checked = items.fullscreen;
  });
}

document.addEventListener('DOMContentLoaded', restore_options);
document.getElementById('save').addEventListener('click', save_options);
