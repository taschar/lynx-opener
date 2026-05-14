// Cross-browser compatibility
const browserInstance = typeof browser !== 'undefined' ? browser : chrome;

browserInstance.runtime.onInstalled.addListener(() => {
  browserInstance.contextMenus.create({
    id: "openInLynx",
    title: "Open link in Lynx",
    contexts: ["link"]
  });
});

browserInstance.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "openInLynx") {
    const url = info.linkUrl;
    
    // Get the configured terminal and fullscreen preference from storage
    browserInstance.storage.sync.get({ 
      terminal: 'x-terminal-emulator',
      fullscreen: true 
    }, (items) => {
      const terminal = items.terminal;
      const fullscreen = items.fullscreen;
      
      // Send message to Native Messaging Host
      browserInstance.runtime.sendNativeMessage(
        'com.lynx.opener',
        { url: url, terminal: terminal, fullscreen: fullscreen },
        (response) => {
          if (browserInstance.runtime.lastError) {
            console.error("ERROR: " + browserInstance.runtime.lastError.message);
          } else {
            console.log("Response: ", response);
          }
        }
      );
    });
  }
});
