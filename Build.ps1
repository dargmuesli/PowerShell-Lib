If (-Not (Get-Module -ListAvailable -Name "platyPS")) {
    Write-Host "Installing platyPS..."
    Install-Module -Name "platyPS" -Scope "CurrentUser" -Force
}

Import-Module -Name "${PSScriptRoot}\PowerShell-Lib"

Write-Host "Making build folders..."
$BuildFolders = @("PowerShell-Lib\Docs", "PowerShell-Lib\en-US")

ForEach ($BuildFolder In $BuildFolders) {
    If (Test-Path -Path $BuildFolder) {
        Remove-Item -Path "$BuildFolder\*"
    } Else {
        New-Item -Path $BuildFolder -Type "Directory"
    }
}

Write-Host "Running New-MarkdownHelp..."
New-MarkdownHelp -Module "PowerShell-Lib" -OutputFolder ".\PowerShell-Lib\Docs" -Locale "en-US"
Write-Host "Running New-ExternalHelp..."
New-ExternalHelp -Path ".\PowerShell-Lib\Docs" -OutputPath ".\PowerShell-Lib\en-US"

Write-Host "Done!"
