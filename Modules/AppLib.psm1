Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Returns a list of installed apps on the current computer.

    .DESCRIPTION
    The "Get-AppsInstalled" cmdlet gets the registry's uninstall keys depending on the system's architecture.
    Then it filters all subkeys by the existence of a "DisplayName" and properties given in the "SelectObjectProperty" parameter.
    Finally it sorts all found apps by their "DisplayName" and returns them.

    .PARAMETER SelectObjectProperty
    The properties to select.

    .PARAMETER SortObjectProperty
    The properties to sort by.

    .EXAMPLE
    Get-AppsInstalled -SelectObjectProperty @("DisplayName", "DisplayVersion") -SortObjectProperty @("DisplayName", "DisplayVersion")

    .LINK
    Source: https://stackoverflow.com/a/31714410
#>
Function Get-AppsInstalled {
    Param (
        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [Object] $SelectObjectProperty = @("DisplayName"),

        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [Object] $SortObjectProperty = @("DisplayName")
    )

    $SystemBit = Get-SystemBit
    $RegPath = $Null

    Switch ($SystemBit) {
        32 {
            $RegPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
        }
        64 {
            $RegPath = @(
                'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
                'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
            )
        }
    }

    Get-ItemProperty -Path $RegPath |
        ForEach-Object {
        Process {
            If (Test-PropertyExist -Object $PSItem -PropertyName "DisplayName") {
                $PSItem
            }
        }
    } |
        Select-Object -Property $SelectObjectProperty |
        Sort-Object -Property $SortObjectProperty
}

<#
    .SYNOPSIS
    Installs an app on the current computer.

    .DESCRIPTION
    The "Install-App" cmdlet starts an type-dependent installer and waits for it's completion.

    .PARAMETER InstallerPath
    The path to where the installer is located.
    File extensions ".exe" and ".msi" are supported.

    .EXAMPLE
    Install-App -InstallerPath ".\installer.msi"
#>
Function Install-App {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $InstallerPath
    )

    Switch ([System.IO.Path]::GetExtension($InstallerPath)) {
        ".exe" {
            Start-Process $InstallerPath -Wait
            Break
        }
        ".msi" {
            Start-Process msiexec.exe -Wait -ArgumentList "/I $InstallerPath"
            Break
        }
        default {
            Throw "File extension of `"$InstallerPath`" is neither `".exe`" nor `".msi`"."
            Break
        }
    }
}

<#
    .SYNOPSIS
    Checks if an app in installed on the current computer.

    .DESCRIPTION
    The "Test-AppInstalled" cmdlet gets a list of all installed apps and checks if the value of parameter "AppName" occurs within the list.
    If that is the case, "True" is returned.

    .PARAMETER AppName
    The app name to check.

    .PARAMETER RegexCompare
    Whether to match the app name literally or by using patterns.

    .EXAMPLE
    Test-AppInstalled -AppName "Docker Toolbox version \d+\.\d+\.\d+(-ce)*" -RegexCompare
#>
Function Test-AppInstalled {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $AppName,

        [Parameter(Mandatory = $False)]
        [Switch] $RegexCompare
    )

    $AppsFound = Get-AppsInstalled |
        Where-Object {
        If ($RegexCompare) {
            $PSItem.DisplayName -CMatch $AppName
        } Else {
            $PSItem.DisplayName -Eq $AppName
        }
    }
    
    If ($AppsFound) {
        Return $True
    } Else {
        Return $False
    }
}

Export-ModuleMember -Function *
