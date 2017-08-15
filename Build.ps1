If (-Not (Get-Module -ListAvailable -Name "platyPS")) {
    Write-Host "Installing platyPS..." -ForegroundColor "Cyan"
    Install-Module -Name "platyPS" -Scope "CurrentUser" -Force
}

Import-Module -Name "${PSScriptRoot}\PowerShell-Lib\PowerShell-Lib.psd1" -Force

Write-Host "Clearing build folders..." -ForegroundColor "Cyan"
$BuildFolders = @("PowerShell-Lib\Docs", "PowerShell-Lib\en-US")

ForEach ($BuildFolder In $BuildFolders) {
    Get-ChildItem -Path "$BuildFolder\*" | ForEach-Object {
        Get-ChildItem -Path $PSItem
        Remove-Item -Path $PSItem
    }
}

Write-Host "Running New-MarkdownHelp..." -ForegroundColor "Cyan"
New-MarkdownHelp -Module "PowerShell-Lib" -OutputFolder ".\PowerShell-Lib\Docs" -Locale "en-US"
Write-Host "Running New-ExternalHelp..." -ForegroundColor "Cyan"
New-ExternalHelp -Path ".\PowerShell-Lib\Docs" -OutputPath ".\PowerShell-Lib\en-US"

Write-Host "Creating root README..." -ForegroundColor "Cyan"
$ReadmeRoot = Get-Content -Path ".\README\root.md" -Raw
$ReadmeModules = New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\*") -DocPath "PowerShell-Lib/Docs" -Sort
$Readme = Join-MultiLineStrings -MultiLineStrings @($ReadmeRoot, $ReadmeModules) -Newline
[System.IO.File]::WriteAllLines("${PSScriptRoot}\README.md", $Readme)

Write-Host "Done!" -ForegroundColor "Green"
