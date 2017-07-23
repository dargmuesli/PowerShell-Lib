Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Reads settings fields in the JSON format and returns a PSCustomObject.

    .DESCRIPTION
    Merges each source file's settings on top of the others.

    .PARAMETER SourcePath
    An array of settings files.

    .EXAMPLE
    $Settings = Read-Settings -SourcePath @("${ProjectPath}\package.json", "${ProjectPath}\docker-management.json")
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
