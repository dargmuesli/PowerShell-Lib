Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Creates a markdown list for all functions in specified files.

    .DESCRIPTION
    The "New-ModuleMarkdown" cmdlet reads all specified files and searches for function declarations within them.
    It then returns a markdown list representation of all functions.

    .PARAMETER SourcePath
    The path to files that are to be examined.

    .PARAMETER DocPath
    The path to where a functions markdown documentation can be found.

    .PARAMETER EOLCharacter
    End of line character.
    Either "`r", "`n" or `r`n".
    Default is "`n".

    .EXAMPLE
    New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\*") -DocPath "PowerShell-Lib/Docs"

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/New-ModuleMarkdown.md
#>
Function New-ModuleMarkdown {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String[]] $SourcePath,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String] $DocPath,

        [Parameter(Mandatory = $False)]
        [ValidateSet('`r', '`n', '`r`n')]
        [String] $EOLCharacter = "`n"
    )

    $SourceData = [Ordered]@{}

    Foreach ($SourcePathItem In $SourcePath) {
        $SourcePathItem = Get-ChildItem -Path "$SourcePathItem*"

        Foreach ($SourcePathItemItem In $SourcePathItem) {
            $ModuleName = [System.IO.Path]::GetFileNameWithoutExtension($SourcePathItemItem)
            $FunctionNames = (Get-Module $SourcePathItemItem -ListAvailable).ExportedCommands.Keys | Sort-Object

            If (-Not ($SourceData.Contains($ModuleName))) {
                $SourceData.Add($ModuleName, $FunctionNames)
            }
        }
    }

    $MarkdownString = "## Modules"

    Foreach ($SourceDataItem In $SourceData.GetEnumerator()) {
        $MarkdownString += "$EOLCharacter- **$($SourceDataItem.Name)**"

        Foreach ($SourceDataItemValueItem In $SourceDataItem.Value) {
            $MarkdownString += "$EOLCharacter  - [$SourceDataItemValueItem]($DocPath/$SourceDataItemValueItem.md)"
        }
    }

    Return $MarkdownString
}

<#
    .SYNOPSIS
    Reads settings fields in the JSON format and returns a PSCustomObject.

    .DESCRIPTION
    The "Read-Settings" cmdlet merges each source file's settings into a new object on top of the others.

    .PARAMETER SourcePath
    An array of settings file paths.

    .EXAMPLE
    Read-Settings -SourcePath @(".\package.json", ".\docker-management.json")

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Read-Settings.md
#>
Function Read-Settings {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String[]] $SourcePath
    )

    $Settings = [PSCustomObject] @{}

    Foreach ($SourcesPath In $SourcePath) {
        $Settings = Merge-Objects -Object1 $Settings -Object2 (Get-Content -Path $SourcesPath | ConvertFrom-Json)
    }

    Return $Settings
}

Export-ModuleMember -Function *
