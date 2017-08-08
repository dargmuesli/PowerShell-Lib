Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Removes newlines from a string.

    .DESCRIPTION
    The "Clear-Linebreaks" cmdlet removes all line feeds and carriage returns.

    .PARAMETER String
    The input string containing the unneeded newlines.

    .EXAMPLE
    Clear-Linebreaks -String "test`r`n123"
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
