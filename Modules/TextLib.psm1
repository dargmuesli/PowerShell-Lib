Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Removes newlines from a string.

    .DESCRIPTION
    All line feed and carriage return characters are removed.

    .PARAMETER String
    The input string containing the unneeded newlines.

    .EXAMPLE
    $DockerInspectConfigHostname = docker inspect -f "{{.Config.Hostname}}" $Name | Out-String | ForEach-Object {
        If ($PSItem) {
            Clear-Linebreaks -String $PSItem
        }
    }
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
