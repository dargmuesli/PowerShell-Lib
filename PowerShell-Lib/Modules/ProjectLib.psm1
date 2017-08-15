Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Creates a markdown list for all functions in specified files.

    .DESCRIPTION
    The "New-ModuleMarkdown" cmdlet reads all specified files and searches for function declarations within them.
    Then it can sort the findings alphabetically and finally it returns a markdown list representation of all functions.

    .PARAMETER SourcePath
    The path to files that are to be examined.

    .PARAMETER DocPath
    The path to where a functions markdown documentation can be found.

    .PARAMETER Sort
    Whether to sort the findings alphabetically or not.

    .EXAMPLE
    New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\*") -DocPath "PowerShell-Lib/Docs"
#>
Function New-ModuleMarkdown {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String[]] $SourcePath,
        
        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String] $DocPath,
        
        [Parameter(Mandatory = $False, Position = 1)]
        [Switch] $Sort
    )

    $SourceData = @{}

    Foreach ($SourcePathItem In $SourcePath) {
        $SourcePathItem = Get-ChildItem -Path $SourcePathItem

        Foreach ($SourcePathItemItem In $SourcePathItem) {
            $ModuleName = [System.IO.Path]::GetFileNameWithoutExtension($SourcePathItemItem)
            $FunctionNames = Get-Content -Path $SourcePathItemItem |
                Select-String -Pattern "^Function\s(.*)\s\{$" |
                ForEach-Object {
                $PSItem.Matches.Groups[1].Value
            }

            If (-Not ($SourceData.Contains($ModuleName))) {
                $SourceData.Add($ModuleName, $FunctionNames)
            }
        }
    }

    If ($Sort) {
        $SourceData = $SourceData.GetEnumerator() | Sort-Object -Property Name
    }

    $MarkdownString = "## Modules"

    Foreach ($SourceDataItem In $SourceData.GetEnumerator()) {
        $MarkdownString += "`n- **$($SourceDataItem.Name)**"

        Foreach ($SourceDataItemValueItem In $SourceDataItem.Value) {
            $MarkdownString += "`n  - [$SourceDataItemValueItem]($DocPath/$SourceDataItemValueItem.md)"
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
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Read-Settings.md
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
