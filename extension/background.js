chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: "openInLynx",
    title: "Open link in Lynx",
    contexts: ["link"]
  });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "openInLynx") {
    const url = info.linkUrl;
    
    // Get the configured terminal from storage, default to 'x-terminal-emulator'
    chrome.storage.sync.get({ terminal: 'x-terminal-emulator' }, (items) => {
      const terminal = items.terminal;
      
      // Send message to Native Messaging Host
      chrome.runtime.sendNativeMessage(
        'com.lynx.opener',
        { url: url, terminal: terminal },
        (response) => {
          if (chrome.runtime.lastError) {
            console.error("ERROR: " + chrome.runtime.lastError.message);
          } else {
            console.log("Response: ", response);
          }
        }
      );
    });
  }
});
