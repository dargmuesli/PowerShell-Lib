Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Returns a list of installed apps on the current computer.

    .DESCRIPTION
    The "Get-AppsInstalled" cmdlet - on Windows - gets the registry's uninstall keys depending on the system's architecture.
    Then it filters all subkeys by the existence of a "DisplayName" and properties given in the "SelectObjectProperty" parameter.
    Finally it sorts all found apps by their "DisplayName" and returns them.
    On Linux a simple package list is returned with a format dedending on each package manager.

    .PARAMETER SelectObjectProperty
    The properties to select.

    .PARAMETER SortObjectProperty
    The properties to sort by.

    .PARAMETER PackageManager
    The package manager to use.
    Defaults to automatic detection.
    Currently only Pacman is supported.

    .EXAMPLE
    Get-AppsInstalled -SelectObjectProperty @("DisplayName", "DisplayVersion") -SortObjectProperty @("DisplayName", "DisplayVersion")

    .NOTES
    Source: https://stackoverflow.com/a/31714410

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-AppsInstalled.md
#>
Function Get-AppsInstalled {
    Param (
        [Parameter(
            ParameterSetName = 'Windows',
            Mandatory = $False
        )]
        [ValidateNotNullOrEmpty()]
        [Object] $SelectObjectProperty = @("DisplayName"),

        [Parameter(
            ParameterSetName = 'Windows',
            Mandatory = $False
        )]
        [ValidateNotNullOrEmpty()]
        [Object] $SortObjectProperty = @("DisplayName"),

        [Parameter(
            ParameterSetName = 'Linux',
            Mandatory = $True
        )]
        [ValidateSet('Pacman')]
        [String] $PackageManager = (Get-DefaultPackageManager)
    )

    If (Test-IsWindows) {
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
            Where-Object {
            $PSItem -And (Test-PropertyExists -Object $PSItem -PropertyName "DisplayName")
        } |
            Select-Object -Property $SelectObjectProperty |
            Sort-Object -Property $SortObjectProperty
    } ElseIf (Test-IsLinux) {
        Switch ($PackageManager) {
            "Pacman" {
                Invoke-Command -ScriptBlock {pacman -Qeq}
            }
        }
    } Else {
        Write-Warning -Message "This cmdlet is not yet fully PowerShell Core compatible."
    }
}

<#
    .SYNOPSIS
    Installs an app on the current computer.

    .DESCRIPTION
    The "Install-App" cmdlet starts an type-dependent installer and waits for its completion.

    .PARAMETER InstallerPath
    The path to where the installer is located.
    File extensions ".exe" and ".msi" are supported.

    .EXAMPLE
    Install-App -InstallerPath ".\installer.msi"

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Install-App.md
#>
Function Install-App {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $InstallerPath
    )

    If (Test-IsWindows) {
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
    } Else {
        Write-Warning -Message "This cmdlet is not yet fully PowerShell Core compatible."
    }
}

<#
    .SYNOPSIS
    Checks whether an app in installed on the current computer.

    .DESCRIPTION
    The "Test-AppInstalled" cmdlet - on Windows - gets a list of all installed apps and checks if the value of parameter "AppName" occurs within the list.
    If that is the case, "True" is returned.
    On Linux a package manager dependent parsing is applied and searched for the desired package.

    .PARAMETER AppName
    The app name to check.

    .PARAMETER PackageManager
    The package manager to use.
    Defaults to automatic detection.
    Currently only Pacman is supported.

    .PARAMETER RegexCompare
    Whether to match the app name literally or by using patterns.

    .EXAMPLE
    Test-AppInstalled -AppName "Docker Toolbox version \d+\.\d+\.\d+(-ce)*" -RegexCompare

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-AppInstalled.md
#>
Function Test-AppInstalled {
    Param (
        [Parameter(
            ParameterSetName = 'Default',
            Mandatory = $True,
            Position = 0
        )]
        [Parameter(
            ParameterSetName = 'Linux',
            Mandatory = $True,
            Position = 0
        )]
        [ValidateNotNullOrEmpty()]
        [String] $AppName,

        [Parameter(
            ParameterSetName = 'Linux',
            Mandatory = $True
        )]
        [ValidateSet('Pacman')]
        [String] $PackageManager = (Get-DefaultPackageManager),

        [Switch] $RegexCompare
    )

    $AppsFound = $Null

    If (Test-IsWindows) {
        $AppsFound = Get-AppsInstalled |
            Where-Object {
            If (Test-PropertyExists -Object $PSItem -PropertyName "DisplayName") {
                If ($RegexCompare) {
                    $PSItem.DisplayName -CMatch $AppName
                } Else {
                    $PSItem.DisplayName -Eq $AppName
                }
            }
        }
    } ElseIf (Test-IsLinux) {
        Switch ($PackageManager) {
            "Pacman" {
                $AppsFound = Get-AppsInstalled -PackageManager $PackageManager |
                    Where-Object {
                    $Captures = [RegEx]::Match($PSItem, "^([^\s]+)$").Captures

                    If ($Captures.Count -Eq 0) {
                        Break
                    }

                    $Name = $Captures.Groups[1].Value

                    If ($RegexCompare) {
                        $Name -CMatch $AppName
                    } Else {
                        $Name -Eq $AppName
                    }
                }
            }
        }
    } Else {
        Write-Warning -Message "This cmdlet is not yet fully PowerShell Core compatible."
    }

    If ($AppsFound) {
        Return $True
    } Else {
        Return $False
    }
}

Export-ModuleMember -Function *
