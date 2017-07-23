Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Removes newlines from string.

    .DESCRIPTION
    Every line feed and carriage return characters are replaced with nothing.

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
