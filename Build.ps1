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

Function Install-Dependencies {
    Param (
        [Switch] $Only
    )

    If (-Not (Get-PackageSource -Name "NuGet" -ErrorAction "SilentlyContinue")) {
        Register-PackageSource -Name "NuGet" -ProviderName "NuGet" -Location "https://www.nuget.org/api/v2/"
    }

    Write-Host "Installing dependencies..." -ForegroundColor "Cyan"

    Install-ModuleOnce -Name @("platyPS", "Pester") -Force
    Install-PackageOnce -Name @("YamlDotNet") -Destination "Packages" -Force
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
    $ReadmeModules = New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\") -DocPath "PowerShell-Lib/Docs"
    $Readme = Join-MultiLineStrings -MultiLineStrings @($ReadmeRoot, $ReadmeModules) -Newline
    [System.IO.File]::WriteAllLines("${PSScriptRoot}\README.md", $Readme)
}

Switch ($Task) {
    "Default" {
        Import-RootModule -Only
        Install-Dependencies -Only
        Test-Pester -Only
        Import-RootModule -Only
        Clear-BuildFolders -Only
        New-Help -Only
        New-Readme -Only
        Break
    }
    "CI" {
        Import-RootModule -Only
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
