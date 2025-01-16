# AMDHotkeysModule

## Overview

The AMDHotkeysModule is a PowerShell module designed to manage AMD's Radeon software hotkeys via the Windows registry. It provides functions to enable, disable, clear, and restore hotkeys.

## Purpose

AMD's Radeon software was registering the Alt+Z hotkey (even after disabling hotkeys in the app), which  prevented Visual Studio Code from using Alt+Z to toggle word wrap. This module provides a quick way to forcibly disable AMD's hotkeys.

## Installation

To install the AMDHotkeysModule, follow these steps:

1. Download the module files.
2. Place the `AMDHotkeysModule` folder in one of the following locations:
   - `$HOME\Documents\WindowsPowerShell\Modules`
   - `$PSModulePath` (check the current paths using `$env:PSModulePath`)

## Usage

To use the module, first import it into your PowerShell session:

```powershell
Import-Module AMDHotkeysModule
```

### Functions

- **Get-AMDHotkeysStatus**
  - Retrieves the current status of AMD hotkeys.

- **Disable-AMDHotkeys**
  - Disables all AMD hotkeys.

- **Enable-AMDHotkeys**
  - Enables all AMD hotkeys.

- **Clear-AMDHotkeys**
  - Clears all custom hotkey settings in the registry.

- **Restore-AMDHotkeys**
  - Restores the default hotkey settings in the registry.

## Example

To disable AMD hotkeys, you can run:

```powershell
Disable-AMDHotkeys
```

To enable AMD hotkeys, you can run:

```powershell
Enable-AMDHotkeys
```

To restore the default hotkeys, use:

```powershell
Restore-AMDHotkeys
```

## Author

This module was created by John Gibbs.

## License

This project is licensed under the MIT License.
