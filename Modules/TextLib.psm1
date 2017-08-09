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
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Clear-Linebreaks.md
#>
Function Clear-Linebreaks {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $String
    )

    $String -Replace "`r", "" -Replace "`n", ""
}

Export-ModuleMember -Function *
