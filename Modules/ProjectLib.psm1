Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Reads settings fields in the JSON format and returns a PSCustomObject.

    .DESCRIPTION
    The "Read-Settings" cmdlet merges each source file's settings into a new object on top of the others.

    .PARAMETER SourcePath
    An array of settings file paths.

    .EXAMPLE
    Read-Settings -SourcePath @(".\package.json", ".\docker-management.json")
#>
Function Read-Settings {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String[]] $SourcePath
    )

    $Settings = [PSCustomObject] @{}

    Foreach ($SourcesPath In $SourcePath) {
        If (Test-Path $SourcesPath) {
            $Settings = Merge-Objects -Object1 $Settings -Object2 (Get-Content -Path $SourcesPath | ConvertFrom-Json)
        }
    }

    Return $Settings
}

Export-ModuleMember -Function *
