Param (
    [Parameter(Mandatory = $False)]
    [ValidateSet('Default', 'Initialize-Modules', 'Clear-BuildFolders', 'New-Help', 'New-Readme')]
    [String] $Task = "Default"
)

Set-StrictMode -Version Latest

Function Initialize-Modules {
    If (-Not (Get-Module -ListAvailable -Name "platyPS")) {
        Write-Host "Installing platyPS..." -ForegroundColor "Cyan"
        Install-Module -Name "platyPS" -Scope "CurrentUser" -Force
    }
}

Function Clear-BuildFolders {
    Write-Host "Clearing build folders..." -ForegroundColor "Cyan"
    $BuildFolders = @("PowerShell-Lib\Docs", "PowerShell-Lib\en-US")

    ForEach ($BuildFolder In $BuildFolders) {
        Get-ChildItem -Path "$BuildFolder\*" | ForEach-Object {
            Get-ChildItem -Path $PSItem
            Remove-Item -Path $PSItem
        }
    }
}

Function New-Help {
    Initialize-Modules
    Clear-BuildFolders

    Write-Host "Generating markdown help..." -ForegroundColor "Cyan"
    New-MarkdownHelp -Module "PowerShell-Lib" -OutputFolder ".\PowerShell-Lib\Docs" -Locale "en-US"
    Write-Host "Generating external help..." -ForegroundColor "Cyan"
    New-ExternalHelp -Path ".\PowerShell-Lib\Docs" -OutputPath ".\PowerShell-Lib\en-US"
}

Function New-Readme {
    Write-Host "Generating README..." -ForegroundColor "Cyan"
    $ReadmeRoot = Get-Content -Path ".\README\root.md" -Raw
    $ReadmeModules = New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\*") -DocPath "PowerShell-Lib/Docs" -Sort
    $Readme = Join-MultiLineStrings -MultiLineStrings @($ReadmeRoot, $ReadmeModules) -Newline
    [System.IO.File]::WriteAllLines("${PSScriptRoot}\README.md", $Readme)
}

Import-Module -Name "${PSScriptRoot}\PowerShell-Lib\PowerShell-Lib.psd1" -Force

Switch ($Task) {
    "Default" {
        Initialize-Modules
        Clear-BuildFolders
        New-Help
        New-Readme
        Break
    }
    Default {
        Invoke-Expression -Command $Task
        Break
    }
}

Write-Host "Done!" -ForegroundColor "Green"
