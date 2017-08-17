Param (
    [Parameter(Mandatory = $False)]
    [ValidateSet('Default', 'CI', 'Initialize-Modules', 'Test-Pester', 'Clear-BuildFolders', 'New-Help', 'New-Readme')]
    [String] $Task = "Default"
)

Set-StrictMode -Version Latest

Function Import-RootModule {
    Param (
        [Switch] $Only
    )

    Import-Module -Name "${PSScriptRoot}\PowerShell-Lib\PowerShell-Lib.psd1" -Force
}

Function Initialize-Modules {
    Param (
        [Switch] $Only
    )

    If (-Not (Get-Module -ListAvailable -Name "platyPS")) {
        Write-Host "Installing modules..." -ForegroundColor "Cyan"
        Install-Module -Name @("platyPS", "Pester") -Scope "CurrentUser" -Force
    }
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
        Initialize-Modules
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
    $ReadmeModules = New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\*") -DocPath "PowerShell-Lib/Docs" -Sort
    $Readme = Join-MultiLineStrings -MultiLineStrings @($ReadmeRoot, $ReadmeModules) -Newline
    [System.IO.File]::WriteAllLines("${PSScriptRoot}\README.md", $Readme)
}

Switch ($Task) {
    "Default" {
        Test-Pester -Only
        Import-RootModule -Only
        Initialize-Modules -Only
        Clear-BuildFolders -Only
        New-Help -Only
        New-Readme -Only
        Break
    }
    "CI" {
        Initialize-Modules -Only
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
