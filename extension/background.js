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
    
    // Get the configured terminal and fullscreen preference from storage
    chrome.storage.sync.get({ 
      terminal: 'x-terminal-emulator',
      fullscreen: true 
    }, (items) => {
      const terminal = items.terminal;
      const fullscreen = items.fullscreen;
      
      // Send message to Native Messaging Host
      chrome.runtime.sendNativeMessage(
        'com.lynx.opener',
        { url: url, terminal: terminal, fullscreen: fullscreen },
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
