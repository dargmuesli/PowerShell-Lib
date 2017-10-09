Param (
    [Parameter(Mandatory = $False)]
    [ValidateSet('Default', 'CI', 'Install-Dependencies', 'Test-Pester', 'Clear-BuildFolders', 'New-Help', 'New-Readme')]
    [String] $Task = "Default"
)

Set-StrictMode -Version Latest

Function Import-RootModule {
    Param (
        [Switch] $Only
    )

    Import-Module -Name "${PSScriptRoot}\PowerShell-Lib\PowerShell-Lib.psd1" -Force
}

Function Install-Modules {
    Param (
        [Switch] $Only
    )

    Write-Host "Installing modules..." -ForegroundColor "Cyan"

    $Modules = @("platyPS", "Pester")

    ForEach ($Module In $Modules) {
        If (-Not (Get-Module -Name $Module -ListAvailable)) {
            Install-Module -Name $Module -Scope "CurrentUser" -Force
        }
    }
}

Function Install-Packages {
    Param (
        [Switch] $Only
    )

    Write-Host "Installing packages..." -ForegroundColor "Cyan"

    $Packages = @("YamlDotNet")

    ForEach ($Package In $Packages) {
        If (-Not (Get-Package -Name $Package -Destination "Packages" -ErrorAction SilentlyContinue)) {
            Install-Package -Name $Package -Destination "Packages" -Force
        }
    }
}

Function Install-Dependencies {
    Param (
        [Switch] $Only
    )

    Write-Host "Installing dependencies..." -ForegroundColor "Cyan"

    Install-Modules
    Install-Packages
}

Function Test-Pester {
    Param (
        [Switch] $Only
    )

    Write-Host "Running Tests..." -ForegroundColor "Cyan"
    $Pester = Invoke-Pester -PassThru

    If ($Pester.FailedCount -Gt 0) {
        Throw "$(${Pester}.FailedCount) tests failed."
    }
}

Function Clear-BuildFolders {
    Param (
        [Switch] $Only
    )

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
    Param (
        [Switch] $Only
    )

    If (-Not $Only) {
        Install-Dependencies
        Clear-BuildFolders
    }

    Write-Host "Generating markdown help..." -ForegroundColor "Cyan"
    New-MarkdownHelp -Module "PowerShell-Lib" -OutputFolder ".\PowerShell-Lib\Docs" -Locale "en-US"
    Write-Host "Generating external help..." -ForegroundColor "Cyan"
    New-ExternalHelp -Path ".\PowerShell-Lib\Docs" -OutputPath ".\PowerShell-Lib\en-US"
}

Function New-Readme {
    Param (
        [Switch] $Only
    )

    Write-Host "Generating README..." -ForegroundColor "Cyan"
    $ReadmeRoot = Get-Content -Path ".\README\root.md" -Raw
    $ReadmeModules = New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\") -DocPath "PowerShell-Lib/Docs" -Sort
    $Readme = Join-MultiLineStrings -MultiLineStrings @($ReadmeRoot, $ReadmeModules) -Newline
    [System.IO.File]::WriteAllLines("${PSScriptRoot}\README.md", $Readme)
}

Switch ($Task) {
    "Default" {
        Install-Dependencies -Only
        Test-Pester -Only
        Import-RootModule -Only
        Clear-BuildFolders -Only
        New-Help -Only
        New-Readme -Only
        Break
    }
    "CI" {
        Install-Dependencies -Only
        Import-RootModule -Only
        Clear-BuildFolders -Only
        New-Help -Only
        New-Readme -Only
        Break
    }
    Default {
        Invoke-Expression -Command $Task
        Break
    }
}

Write-Host "Done!" -ForegroundColor "Green"
