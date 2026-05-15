# Lynx Opener v3.0

[English version](#english) | [Ελληνική έκδοση](#greek)

<a name="english"></a>
## English (v3.0)

Lynx Opener is a browser extension for **Linux, macOS, and Windows** that allows you to open any link in the **Lynx** text-browser within a terminal emulator.

### New in v3.0
- **Cross-Platform Support:** Works on Windows, macOS, and Linux.
- **Improved Host Logic:** Enhanced terminal detection and fullscreen support.
- **Universal Installer:** Simplified scripts for all operating systems.

### Installation

#### 1. Load the Extension

**For Chrome / Brave / Edge / Chromium:**
1.  Navigate to `chrome://extensions/`.
2.  Enable **Developer mode**.
3.  Click **Load unpacked**.
4.  Select the **`extension-chrome`** folder.
5.  Copy the **Extension ID** (needed for step 2).

**For Firefox:**
1.  Navigate to `about:debugging#/runtime/this-firefox`.
2.  Click **Load Temporary Add-on...**.
3.  Select the `manifest.json` inside the **`extension-firefox`** folder.

#### 2. Install the Native Messaging Host

**Linux / macOS:**
1.  Open a terminal in the repository root.
2.  Run `chmod +x install.sh && ./install.sh`.
3.  Provide the Chrome Extension ID if prompted.

**Windows:**
1.  Open PowerShell as Administrator.
2.  Run `./install/install_windows.ps1`.
3.  Provide the Chrome Extension ID if prompted.

---

<a name="greek"></a>
## Ελληνικά (v3.0)

Το Lynx Opener είναι μια επέκταση περιηγητή για **Linux, macOS και Windows** που σας επιτρέπει να ανοίγετε οποιονδήποτε σύνδεσμο στον text-browser **Lynx** μέσα σε έναν εξομοιωτή τερματικού.

### Νέα στην έκδοση 3.0
- **Υποστήριξη πολλαπλών πλατφορμών:** Λειτουργεί σε Windows, macOS και Linux.
- **Βελτιωμένη Λογική Host:** Καλύτερος εντοπισμός τερματικού και υποστήριξη πλήρους οθόνης.
- **Καθολικός Εγκαταστάτης:** Απλοποιημένα scripts για όλα τα λειτουργικά συστήματα.

### Εγκατάσταση

#### 1. Φόρτωση της Επέκτασης

**Για Chrome / Brave / Edge / Chromium:**
1.  Μεταβείτε στο `chrome://extensions/`.
2.  Ενεργοποιήστε τη **Λειτουργία προγραμματιστή**.
3.  Κάντε κλικ στο **Φόρτωση μη συσκευασμένης επέκτασης**.
4.  Επιλέξτε το φάκελο **`extension-chrome`**.
5.  Αντιγράψτε το **Extension ID**.

**Για Firefox:**
1.  Μεταβείτε στο `about:debugging#/runtime/this-firefox`.
2.  Κάντε κλικ στο **Load Temporary Add-on...**.
3.  Επιλέξτε το `manifest.json` μέσα στο φάκελο **`extension-firefox`**.

#### 2. Εγκατάσταση του Native Messaging Host

**Linux / macOS:**
1.  Ανοίξτε ένα τερματικό στο φάκελο του έργου.
2.  Εκτελέστε `chmod +x install.sh && ./install.sh`.
3.  Δώστε το Chrome Extension ID αν ζητηθεί.

**Windows:**
1.  Ανοίξτε το PowerShell ως Διαχειριστής.
2.  Εκτελέστε `./install/install_windows.ps1`.
3.  Δώστε το Chrome Extension ID αν ζητηθεί.

---
## License
MIT
