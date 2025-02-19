@{
    Description = 'A PowerShell module for managing AMD Radeon Software hotkeys through the Windows registry.'
    Author = 'John Gibbs'
    Copyright = '(c) 2025 John Gibbs. All rights reserved.'

    RootModule = 'AMDHotkeysModule.psm1'
    GUID = 'd3b1c3f4-5e6a-4b8b-9c3e-1f2e3d4c5b6a'
    ModuleVersion = '0.0.1'
    PowerShellVersion = '5.1'
    CompatiblePSEditions = @('Desktop')

    RequiredModules = @()
    RequiredAssemblies = @()

    FunctionsToExport = @(
        'Test-AMDHotkeysEnabled',
        'Disable-AMDHotkeys',
        'Enable-AMDHotkeys',
        'Get-AMDHotkeys',
        'Clear-AMDHotkeys',
        'Restore-AMDHotkeys'
    )
    CmdletsToExport = @()
    VariablesToExport = @()
    AliasesToExport = @()
    NestedModules = @()

    FileList = @(
        'AMDHotkeysModule.psm1',
        'AMDHotkeysModule.psd1'
    )
    PrivateData = @{
        PSData = @{
            Tags = @('AMD', 'Radeon', 'Hotkeys', 'Registry')
            LicenseUri = 'https://opensource.org/licenses/MIT'
            ProjectUri = 'https://github.com/johngibbs/AMDHotkeysModule'
            IconUri = 'https://example.com/icon.png'
            ReleaseNotes = 'Initial release of the AMDHotkeysModule.'
        }
    }
}