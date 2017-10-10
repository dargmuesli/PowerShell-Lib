Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Removes newlines from a string.

    .DESCRIPTION
    The "Clear-Linebreaks" cmdlet replaces every line feed and carriage return characters with nothing.

    .PARAMETER String
    The input string containing the unneeded newlines.

    .EXAMPLE
    Clear-Linebreaks -String "test`r`n123"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Clear-Linebreaks.md
#>
Function Clear-Linebreaks {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $String
    )

    $String -Replace "`r|`n", ""
}

<#
    .SYNOPSIS
    Joins multi line strings.

    .DESCRIPTION
    The "Join-MultiLineStrings" cmdlet iterates over all multi line strings, adding an optional newline between each and appending each to the return string.

    .PARAMETER MultiLineStrings
    The multi line strings that are to be joined.

    .PARAMETER Newline
    Whether to insert a newline between each string.

    .EXAMPLE
    $FileA = Get-Content -Path ".\FileA.md" -Raw
    $FileB = Get-Content -Path ".\FileB.md" -Raw

    Join-MultiLineStrings -MultiLineStrings @($FileA, $FileB) -Newline

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Join-MultiLineStrings.md
#>
Function Join-MultiLineStrings {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String[]] $MultiLineStrings,

        [Switch] $Newline
    )

    $OutputString = $Null
    $I = 0

    ForEach ($MultiLineString In $MultiLineStrings) {
        $I++
        $OutputString += $MultiLineString

        If (($Newline) -And ($I -Ne $MultiLineStrings.Count)) {
            $OutputString += "`r`n"
        }
    }

    $OutputString
}

Export-ModuleMember -Function *
