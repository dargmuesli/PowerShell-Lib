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
Function Get-AppsInstalled {
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
            If (Test-PropertyExists -Object $PSItem -PropertyName "DisplayName") {
                $PSItem
            }
        }
    } | Select-Object DisplayName, Publisher, InstallDate, DisplayVersion, UninstallString | Sort-Object DisplayName
}

Function Test-AppInstalled {
    Param (
        [Parameter(Mandatory = $True)] [String] $AppName
    )
    
    If (Get-AppsInstalled | Where-Object { $PSItem.DisplayName -Like $AppName }) {
        Return $True
    } Else {
        Return $False
    }
}

Export-ModuleMember -Function *
