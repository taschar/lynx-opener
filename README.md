# Lynx Opener v2.0.0

[English version](#english) | [Ελληνική έκδοση](#greek)

<a name="english"></a>
## English

Lynx Opener is a browser extension for Linux that allows you to open any link in the **Lynx** text-browser within a terminal emulator.

### Installation

#### 1. Load the Extension

**For Chrome / Brave / Edge / Chromium:**
1.  Navigate to `chrome://extensions/`.
2.  Enable **Developer mode**.
3.  Click **Load unpacked**.
4.  Select the **`extension-chrome`** folder.
5.  Copy the **Extension ID** (needed for step 2).

**For Firefox:**
*   **Temporary (Testing):**
    1.  Navigate to `about:debugging#/runtime/this-firefox`.
    2.  Click **Load Temporary Add-on...**.
    3.  Select the `manifest.json` inside the **`extension-firefox`** folder.
*   **Permanent (Self-Hosted):**
    1.  Firefox requires extensions to be signed to be installed permanently.
    2.  To install for any user: You can use **Firefox Developer Edition** or **Nightly**, which allow unsigned extensions via `about:config` (`xpinstall.signatures.required` set to `false`).
    3.  Go to `about:addons` -> Gear icon -> **Install Add-on From File...** and select a zipped version of the `extension-firefox` folder.

#### 2. Install the Native Messaging Host
1.  Open a terminal in the repository root.
2.  Run `./install.sh`.
3.  Provide the Chrome Extension ID if prompted.

### Settings & Options

*   **Chrome/Brave:** Right-click the extension icon -> **Options**.
*   **Firefox:**
    1.  Go to `about:addons`.
    2.  Click on **Lynx Opener**.
    3.  Select the **Options** (or Preferences) tab.
    4.  Here you can set your preferred **Terminal** and **Fullscreen** mode.

---

<a name="greek"></a>
## Ελληνικά (v2.0.0)

### Εγκατάσταση

#### 1. Φόρτωση της Επέκτασης

**Για Chrome / Brave / Edge / Chromium:**
1.  Μεταβείτε στο `chrome://extensions/`.
2.  Ενεργοποιήστε τη **Λειτουργία προγραμματιστή**.
3.  Κάντε κλικ στο **Φόρτωση μη συσκευασμένης επέκτασης**.
4.  Επιλέξτε το φάκελο **`extension-chrome`**.
5.  Αντιγράψτε το **Extension ID**.

**Για Firefox:**
*   **Προσωρινή (για δοκιμή):**
    1.  Μεταβείτε στο `about:debugging#/runtime/this-firefox`.
    2.  Κάντε κλικ στο **Load Temporary Add-on...**.
    3.  Επιλέξτε το `manifest.json` μέσα στο φάκελο **`extension-firefox`**.
*   **Μόνιμη Εγκατάσταση:**
    1.  Ο Firefox απαιτεί οι επεκτάσεις να είναι "υπογεγραμμένες" (signed) από το Mozilla για μόνιμη εγκατάσταση.
    2.  Για εγκατάσταση σε οποιονδήποτε χρήστη χωρίς υπογραφή: Χρησιμοποιήστε τον **Firefox Developer Edition** ή **Nightly**. Ρυθμίστε το `xpinstall.signatures.required` σε `false` στο `about:config`.
    3.  Μεταβείτε στο `about:addons` -> Εικονίδιο γραναζιού -> **Install Add-on From File...** και επιλέξτε ένα αρχείο .zip του φακέλου `extension-firefox`.

### Ρυθμίσεις (Options)

*   **Chrome/Brave:** Δεξί κλικ στο εικονίδιο της επέκτασης -> **Επιλογές**.
*   **Firefox:**
    1.  Μεταβείτε στο `about:addons`.
    2.  Κάντε κλικ στο **Lynx Opener**.
    3.  Επιλέξτε την καρτέλα **Options** (ή Preferences/Ρυθμίσεις).
    4.  Εκεί μπορείτε να ορίσετε το **Τερματικό** και τη λειτουργία **Πλήρους Οθόνης**.

---
## License
MIT
