Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\ProjectLib.psm1" -Force

Describe "New-ModuleMarkdown" {
    New-Item -Path "TestDrive:\Modules\" -Name "ModuleALib.ps1" -ItemType "File" -Value @"
    Function Get-Module {}
"@ -Force

    New-Item -Path "TestDrive:\Modules\" -Name "ModuleBLib.ps1" -ItemType "File" -Value @"
    Function Install-Module {}
"@ -Force

    It "creates a sorted markdown list for all functions" {
        New-ModuleMarkdown -SourcePath @("TestDrive:\Modules\") -DocPath "Docs" | Should Be @"
## Modules
- **ModuleALib**
  - [Get-Module](Docs/Get-Module.md)
- **ModuleBLib**
  - [Install-Module](Docs/Install-Module.md)
"@
    }
}

Describe "Read-Settings" {
    New-Item -Path "TestDrive:\" -Name "settings-a.json" -ItemType "File" -Value @"
{
    "Key": "value-a"
}
"@

    New-Item -Path "TestDrive:\" -Name "settings-b.json" -ItemType "File" -Value @"
{
    "Key": "value-b"
}
"@

    It "reads settings from JSON to PSCustomObject" {
        If ($PSVersionTable.PSVersion -Ge [System.Version]"6.0") {
            ConvertTo-Json (Read-Settings -SourcePath @("TestDrive:\settings-a.json", "TestDrive:\settings-b.json")) | Should Be @"
{
  "Key": "value-b"
}
"@
        } Else {
            ConvertTo-Json (Read-Settings -SourcePath @("TestDrive:\settings-a.json", "TestDrive:\settings-b.json")) | Should Be @"
{
    "Key":  "value-b"
}
"@
        }
    }
}
