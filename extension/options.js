// Localization
function localize() {
  document.querySelectorAll('[data-i18n]').forEach(element => {
    const key = element.getAttribute('data-i18n');
    element.textContent = chrome.i18n.getMessage(key);
  });
  document.querySelectorAll('[data-i18n-placeholder]').forEach(element => {
    const key = element.getAttribute('data-i18n-placeholder');
    element.placeholder = chrome.i18n.getMessage(key);
  });
}

// Saves options to chrome.storage
function save_options() {
  const select = document.getElementById('terminal-select');
  const customInput = document.getElementById('terminal-custom');
  const fullscreen = document.getElementById('fullscreen').checked;
  
  let terminal = select.value;
  if (terminal === 'custom') {
    terminal = customInput.value;
  }

  chrome.storage.sync.set({
    terminal: terminal,
    fullscreen: fullscreen
  }, () => {
    // Update status to let user know options were saved.
    const status = document.getElementById('status');
    status.textContent = chrome.i18n.getMessage('statusSaved');
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
    const select = document.getElementById('terminal-select');
    const customInput = document.getElementById('terminal-custom');
    const customGroup = document.getElementById('custom-terminal-group');
    
    document.getElementById('fullscreen').checked = items.fullscreen;

    // Check if the saved terminal is one of the options
    let found = false;
    for (let i = 0; i < select.options.length; i++) {
      if (select.options[i].value === items.terminal) {
        select.selectedIndex = i;
        found = true;
        break;
      }
    }

    if (!found) {
      select.value = 'custom';
      customInput.value = items.terminal;
      customGroup.style.display = 'block';
    } else {
      customGroup.style.display = 'none';
    }
  });
}

// Handle select change
document.getElementById('terminal-select').addEventListener('change', (e) => {
  const customGroup = document.getElementById('custom-terminal-group');
  if (e.target.value === 'custom') {
    customGroup.style.display = 'block';
  } else {
    customGroup.style.display = 'none';
  }
});

document.addEventListener('DOMContentLoaded', () => {
  localize();
  restore_options();
});
document.getElementById('save').addEventListener('click', save_options);
