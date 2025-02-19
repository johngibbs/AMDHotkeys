Set-StrictMode -Version 5.1

Set-Variable -Option Constant -Name HotkeysDisabledPath -Value "HKCU:\Software\AMD\DVR\HotkeysDisabled"

Set-Variable -Option Constant -Name Hotkeys -Value ([Ordered]@{
    "HKLM:\Software\AMD\DVR\ToggleRsHotkey"              = "Alt,R"
    "HKLM:\Software\AMD\DVR\ToggleRsPerfUiHotkey"        = "Ctrl+Shift,O"
    "HKLM:\Software\AMD\DVR\ToggleRsPerfRecordingHotkey" = "Ctrl+Shift,L"
    "HKLM:\Software\AMD\DVR\Rotation00Hotkey"            = "Ctrl+Alt,VK_UP"
    "HKLM:\Software\AMD\DVR\Rotation90Hotkey"            = "Ctrl+Alt,VK_LEFT"
    "HKLM:\Software\AMD\DVR\Rotation180Hotkey"           = "Ctrl+Alt,VK_DOWN"
    "HKLM:\Software\AMD\DVR\Rotation270Hotkey"           = "Ctrl+Alt,VK_RIGHT"
    "HKLM:\Software\AMD\DVR\ToggleDvrToolbarHotkey"      = "Alt,Z"
    "HKLM:\Software\AMD\DVR\ToggleDvrRecordingHotkey"    = "Ctrl+Shift,E"
    "HKLM:\Software\AMD\DVR\ToggleStreamingHotkey"       = "Ctrl+Shift,G"
    "HKLM:\Software\AMD\DVR\ToggleCameraHotkey"          = "Ctrl+Shift,C"
    "HKLM:\Software\AMD\DVR\ToggleMicrophoneHotkey"      = "Ctrl+Shift,M"
    "HKLM:\Software\AMD\DVR\TakeScreenshotHotkey"        = "Ctrl+Shift,I"
    "HKLM:\Software\AMD\DVR\SaveInstantReplayHotkey"     = "Ctrl+Shift,S"
    "HKLM:\Software\AMD\DVR\SaveInstantGifHotkey"        = "Ctrl+Shift,J"
    "HKLM:\Software\AMD\DVR\SaveInGameReplayHotkey"      = "Ctrl+Shift,U"
    "HKLM:\Software\AMD\DVR\ToggleUpscaling"             = "Alt,U"
})

<#
.SYNOPSIS
    Checks if AMD Radeon Software is installed on the system.
.DESCRIPTION
    Tests for the existence of required AMD registry paths to determine if AMD Radeon Software is installed.
.EXAMPLE
    Test-AMDSoftwareInstalled
    Returns $true if AMD Radeon Software is installed, $false otherwise.
#>
function Test-AMDSoftwareInstalled
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    if (-not ((Test-Path "HKLM:\Software\AMD\DVR") -and (Test-Path "HKCU:\Software\AMD\DVR")))
    {
        Write-Verbose "Registry path HKLM:\Software\AMD\DVR or HKCU:\Software\AMD\DVR does not exist."
        Write-Warning "AMD Radeon Software is not installed."
        return $false
    }
    Write-Verbose "AMD Radeon Software is installed."
    return $true
}

<#
.SYNOPSIS
    Checks if AMD Radeon Software hotkeys are currently enabled.
.DESCRIPTION
    Tests the HKCU:\Software\AMD\DVR\HotkeysDisabled registry value to determine if AMD Radeon Software hotkeys are enabled.
.EXAMPLE
    Test-AMDHotkeysEnabled
    Returns $true if AMD Radeon Software hotkeys are enabled, $false otherwise.
#>
function Test-AMDHotkeysEnabled
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    $hotkeysDisabled = $null
    
    if (Test-AMDSoftwareInstalled)
    {
        try
        {
            $hotkeysDisabled = Get-ItemPropertyValue `
                -Path (Split-Path $HotkeysDisabledPath -Parent) `
                -Name (Split-Path $HotkeysDisabledPath -Leaf)

            Write-Verbose "$HotkeysDisabledPath registry value: $hotkeysDisabled"
        }
        catch
        {
            Write-Verbose $_.Exception.Message
        }
    }

    return $(if ($hotkeysDisabled -eq 0) {$true} else {$false})
}

<#
.SYNOPSIS
    Disables AMD Radeon Software hotkeys.
.DESCRIPTION
    Disables hotkey functionality.
.EXAMPLE
    Disable-AMDHotkeys
    Disables hotkey functionality.
#>
function Disable-AMDHotkeys
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    if (Test-AMDSoftwareInstalled)
    {
        Set-ItemProperty `
            -Path (Split-Path $HotkeysDisabledPath -Parent) `
            -Name (Split-Path $HotkeysDisabledPath -Leaf) `
            -Value 1
        Restart-AMDSettingsService
    }
}

<#
.SYNOPSIS
    Enables AMD Radeon Software hotkeys.
.DESCRIPTION
    Enables hotkey functionality.
.EXAMPLE
    Enable-AMDHotkeys
    Enables hotkey functionality.
#>
function Enable-AMDHotkeys
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    if (Test-AMDSoftwareInstalled)
    {
        Set-ItemProperty `
            -Path (Split-Path $HotkeysDisabledPath -Parent) `
            -Name (Split-Path $HotkeysDisabledPath -Leaf) `
            -Value 0
        Restart-AMDSettingsService
    }
}

<#
.SYNOPSIS
    Gets all AMD Radeon Software hotkeys bindings.
.DESCRIPTION
    Gets all hotkeys assignments.
.EXAMPLE
    Get-AMDHotkeys
    Gets all hotkeys assignments.
#>
function Get-AMDHotkeys
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    if (Test-AMDSoftwareInstalled)
    {
        $hotkeyList = foreach ($path in $Hotkeys.Keys)
        {
            $value = Get-ItemPropertyValue `
                -Path (Split-Path $path -Parent) `
                -Name (Split-Path $path -Leaf)

            [PSCustomObject][Ordered]@{
                RegistryPath = $path
                Hotkey       = $value
            }
        }
        return $hotkeyList
    }
}

<#
.SYNOPSIS
    Clears all AMD Radeon Software hotkey bindings.
.DESCRIPTION
    Clears all hotkey assignments.
.EXAMPLE
    Clear-AMDHotkeys
    Clears all hotkey assignments.
#>
function Clear-AMDHotkeys
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    if (Test-AMDSoftwareInstalled)
    {
        foreach ($path in $Hotkeys.Keys)
        {
            Set-ItemProperty `
                -Path (Split-Path $path -Parent) `
                -Name (Split-Path $path -Leaf) `
                -Value ""
        }
        Restart-AMDSettingsService
    }
}

<#
.SYNOPSIS
    Restores default AMD Radeon Software hotkey bindings.
.DESCRIPTION
    Restores all hotkey assignments to their default value.
.EXAMPLE
    Restore-AMDHotkeys
    Restores all hotkey assignments to their default value.
#>
function Restore-AMDHotkeys
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    if (Test-AMDSoftwareInstalled)
    {
        foreach ($path in $Hotkeys.Keys)
        {
            Set-ItemProperty `
                -Path (Split-Path $path -Parent) `
                -Name (Split-Path $path -Leaf) `
                -Value $Hotkeys[$path]
        }
        Restart-AMDSettingsService
    }
}

<#
.SYNOPSIS
    Restarts the AMD Radeon Settings Service.
.DESCRIPTION
    Restarts the AMD Radeon Settings Service by terminating the AMDRSServ process, which will automatically restart.
.NOTES
    The AMD Radeon Settings Service is not a standard Windows service and must be restarted by terminating its process.
.EXAMPLE
    Restart-AMDSettingsService
    Restarts the AMD Radeon Settings Service.
#>
function Restart-AMDSettingsService
{
    # Use CmdletBinding to allow for common parameters (e.g. -Verbose)
    [CmdletBinding()] param()

    # AMDRSServ is the AMD Radeon Settings Service. It is not an actual Windows service and so
    #  cannot be restarted with Restart-Service. However, it will automatically restart if we kill
    #  the process.
    Get-Process -Name "AMDRSServ" -ErrorAction SilentlyContinue | Stop-Process -Force
}

Export-ModuleMember `
    -Function `
        Test-AMDHotkeysEnabled, `
        Disable-AMDHotkeys, `
        Enable-AMDHotkeys, `
        Get-AMDHotkeys, `
        Clear-AMDHotkeys, `
        Restore-AMDHotkeys