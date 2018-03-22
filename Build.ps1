Param (
    [Parameter(Mandatory = $False)]
    [ValidateSet('Default', 'CI', 'Install-Dependencies', 'Test-Pester', 'Clear-BuildFolders', 'New-Help', 'New-Readme')]
    [String] $Task = "Default"
)

Set-StrictMode -Version Latest

$PackagePath = Join-Path -Path $PSScriptRoot -ChildPath "Packages"
$ManifestPath = Join-Path -Path $PSScriptRoot -ChildPath "PowerShell-Lib" | Join-Path -ChildPath "PowerShell-Lib.psd1"
$DocsPath = Join-Path -Path $PSScriptRoot -ChildPath "PowerShell-Lib" | Join-Path -ChildPath "Docs"
$ExternalHelpPath = Join-Path -Path $PSScriptRoot -ChildPath "PowerShell-Lib" | Join-Path -ChildPath "en-US"
$ModuleMarkdownPath = Join-Path -Path $PSScriptRoot -ChildPath "PowerShell-Lib" | Join-Path -ChildPath "Modules"
$ReadmeRootPath = Join-Path -Path $PSScriptRoot -ChildPath "README" | Join-Path -ChildPath "root.md"
$ReadmeOutputPath = Join-Path -Path $PSScriptRoot -ChildPath "README.md"

Function Import-RootModule {
    Param (
        [Switch] $Only
    )

    Import-Module -Name $ManifestPath -Force
}

Function Install-Dependencies {
    Param (
        [Switch] $Only
    )

    If (-Not (Get-PackageSource -Name "nuget.org" -ErrorAction "SilentlyContinue")) {
        Register-PackageSource -Name "nuget.org" -ProviderName "NuGet" -Location "https://www.nuget.org/api/v2/"
    }

    Write-Host "Installing dependencies..." -ForegroundColor "Cyan"

    Install-ModuleOnce -Name @("platyPS", "Pester") -Force
    Install-PackageOnce -Name @("YamlDotNet") -Destination $PackagePath -Force
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
    $BuildFolders = @($DocsPath, $ExternalHelpPath)

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
    New-MarkdownHelp -Module "PowerShell-Lib" -OutputFolder $DocsPath -Locale "en-US"

    Write-Host "Generating external help..." -ForegroundColor "Cyan"
    New-ExternalHelp -Path $DocsPath -OutputPath $ExternalHelpPath
}

Function New-Readme {
    Param (
        [Switch] $Only
    )

    Write-Host "Generating README..." -ForegroundColor "Cyan"
    $ReadmeRoot = Get-Content -Path $ReadmeRootPath -Raw
    $ReadmeModules = New-ModuleMarkdown -SourcePath $ModuleMarkdownPath -DocPath "PowerShell-Lib/Docs"
    $Readme = Join-MultiLineStrings -MultiLineStrings @($ReadmeRoot, $ReadmeModules) -Newline

    [System.IO.File]::WriteAllLines($ReadmeOutputPath, $Readme)
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
