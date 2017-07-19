Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example

    .NOTES
    https://stackoverflow.com/a/31714410
#>
Function Get-InstalledApps {
    If ([IntPtr]::Size -Eq 4) {
        $RegPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    } Else {
        $RegPath = @(
            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
            'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
        )
    }

    Get-ItemProperty $RegPath | . {
        Process {
            If ($PSItem.DisplayName -And $PSItem.UninstallString) {
                $PSItem
            }
        }
    } | Select-Object DisplayName, Publisher, InstallDate, DisplayVersion, UninstallString | -Sort-Object DisplayName
}

Export-ModuleMember -Function *