# AMDHotkeys

## Overview

The AMDHotkeys module is a PowerShell module designed to manage AMD Radeon Software hotkeys via the Windows registry. It provides functions to enable, disable, clear, and restore hotkeys.

## Purpose

AMD Radeon Software was registering the Alt+Z hotkey (even after disabling hotkeys in the app), which prevented Visual Studio Code from using Alt+Z to toggle word wrap. This module provides a quick way to forcibly disable AMD Radeon Software hotkeys.

## Installation

To install the AMDHotkeys module, follow these steps:

1. Download the module files.
2. Place the `AMDHotkeys` folder in one of the following locations:
   - `$HOME\Documents\WindowsPowerShell\Modules`
   - `$PSModulePath` (check the current paths using `$env:PSModulePath`)

## Usage

To use the module, first import it into your PowerShell session:

```powershell
Import-Module AMDHotkeys
```

### Functions

- **Test-AMDHotkeysEnabled**
  - Checks if AMD Radeon Software hotkeys are currently enabled.

- **Disable-AMDHotkeys**
  - Disables AMD Radeon Software hotkeys.

- **Enable-AMDHotkeys**
  - Enables AMD Radeon Software hotkeys.

- **Clear-AMDHotkeys**
  - Clears all AMD Radeon Software hotkey bindings.

- **Restore-AMDHotkeys**
  - Restores default AMD Radeon Software hotkey bindings.

## Example

To disable AMD hotkeys, you can run:

```powershell
Disable-AMDHotkeys
```

To enable AMD hotkeys, you can run:

```powershell
Enable-AMDHotkeys
```

To remove all hotkey assignments, you can run:

```powershell
Clear-AMDHotkeys
```

To restore all hotkeys to their default assignments, you can run:

```powershell
Restore-AMDHotkeys
```

## Author

This module was created by John Gibbs.

## License

This project is licensed under the MIT License.
