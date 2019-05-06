Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Gets available exceptions.

    .DESCRIPTION
    The "Get-AvailableExceptions" cmdlet iterates over and filters exceptions so that it returns a list of available excetions.

    .EXAMPLE
    Get-AvailableException

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-AvailableExceptions.md

    .NOTES
    Source: https://gist.github.com/wpsmith/7a4d6ab3e85d3720b883
#>
Function Get-AvailableExceptions {
    $Irregulars = 'Dispose|OperationAborted|Unhandled|ThreadAbort|ThreadStart|TypeInitialization'

    Return [AppDomain]::CurrentDomain.GetAssemblies() |
        Where-Object {
        -Not $PSItem.IsDynamic
    } |
        ForEach-Object {
        $PSItem.GetExportedTypes() -Match 'Exception' -NotMatch $Irregulars |
            Where-Object {
            $PSItem.GetConstructors() -And $(
                Try {
                    $Exception = New-Object $PSItem.FullName
                    New-Object Management.Automation.ErrorRecord $Exception, ErrorID, OpenError, Target
                } Catch {}
            )
        } |
            Select-Object -ExpandProperty FullName
    }
}

<#
    .SYNOPSIS
    Returns the default package manager.

    .DESCRIPTION
    The "Get-DefaultPackageManager" cmdlet returns a package manager name depending on the OS and its version.

    .EXAMPLE
    Get-DefaultPackageManager

    .NOTES
    The list is far from complete and awaits open source contributions!

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-DefaultPackageManager.md
#>
Function Get-DefaultPackageManager {
    If (Test-IsLinux) {
        Switch (Get-LinuxOsId) {
            "arch" {
                Return "Pacman"
            }
        }
    }
}

<#
    .SYNOPSIS
    Returns the user's download folder.

    .DESCRIPTION
    The "Get-DownloadFolder" cmdlet returns the value of a OS version dependent registry value.

    .EXAMPLE
    Get-DownloadFolder

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-DownloadFolder.md
#>
Function Get-DownloadFolder {
    $UserShellFoldersPath = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"

    If (Test-IsWindows) {
        If ((Get-OsVersion).Major -Lt 10) {
            Return Get-ItemPropertyValue -Path $UserShellFoldersPath -Name "{374DE290-123F-4565-9164-39C4925E467B}"
        } Else {
            Return Get-ItemPropertyValue -Path $UserShellFoldersPath -Name "{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}"
        }
    } ElseIf (Test-IsLinux) {
        Return Invoke-Expression -Command "xdg-user-dir DOWNLOAD"
    }
}

<#
    .SYNOPSIS
    Returns the current platform's EOL character.

    .DESCRIPTION
    The "Get-EOLCharacter" cmdlet returns the current platform's end of line character.

    .EXAMPLE
    Get-EOLCharacter

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-EOLCharacter.md
#>
Function Get-EOLCharacter {
    If (Test-IsWindows) {
        return "`r`n"
    } ElseIf (Test-IsLinux) {
        return "`n"
    } ElseIf (Test-IsMacOS) {
        return "`r"
    }
}

<#
    .SYNOPSIS
    Returns the Linux OS ID.

    .DESCRIPTION
    The "Get-LinuxOsId" cmdlet mounts the "/etc/os-release" file and returns the operating system's ID.

    .EXAMPLE
    Get-LinuxOsId

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-LinuxOsId.md
#>
Function Get-LinuxOsId {
    If (Test-IsLinux) {
        If (Test-Path -Path "/etc/os-release") {
            Mount-EnvFile -EnvFilePath "/etc/os-release"
            Return $env:ID
        } Else {
            Write-Warning -Message "File `"/etc/os-release`" not found."
        }
    }
}

<#
    .SYNOPSIS
    Returns the OS version.

    .DESCRIPTION
    The "Get-OsVersion" cmdlet returns the operating system's version.

    .EXAMPLE
    Get-OsVersion

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-OsVersion.md
#>
Function Get-OsVersion {
    Return [System.Environment]::OSVersion.Version
}

<#
    .SYNOPSIS
    Gets the processor bit architecture.

    .DESCRIPTION
    The "Get-SystemBit" cmdlet gets the size of "IntPtr" and return either 32 or 64 accordingly.

    .EXAMPLE
    Get-SystemBit

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-SystemBit.md
#>
Function Get-SystemBit {
    $IntPtrSize = [IntPtr]::Size

    If ($IntPtrSize -Eq 4) {
        Return 32
    } ElseIf ($IntPtrSize -Eq 8) {
        Return 64
    }
}

<#
    .SYNOPSIS
    Tests if administrator permissions are enabled.

    .DESCRIPTION
    The "Test-AdminPermissions" cmdlet verifies that administrator permissions are enabled and returns true on success.

    .EXAMPLE
    Test-AdminPermissions

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-AdminPermissions.md
#>
Function Test-AdminPermissions {
    If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Tests if PowerShell Core is executed.

    .DESCRIPTION
    The "Test-IsCoreCLR" cmdlet checks whether the PS version table contains the "PSEdition" key having the value "Core".

    .EXAMPLE
    Test-IsCoreCLR

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-IsCoreCLR.md
#>
Function Test-IsCoreCLR {
    return $PSVersionTable.ContainsKey("PSEdition") -And $PSVersionTable.PSEdition -eq "Core"
}

<#
    .SYNOPSIS
    Tests if the current platform is Linux.

    .DESCRIPTION
    The "Test-IsLinux" cmdlet checks whether the "IsLinux" variable is set and returns its value.

    .EXAMPLE
    Test-IsLinux

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-IsLinux.md
#>
Function Test-IsLinux {
    return (Get-Variable -Name "IsLinux" -ErrorAction "Ignore") -And $IsLinux
}

<#
    .SYNOPSIS
    Tests if the current platform is MacOS.

    .DESCRIPTION
    The "Test-IsMacOS" cmdlet checks whether the "IsMacOS" variable is set and returns its value.

    .EXAMPLE
    Test-IsMacOS

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-IsMacOS.md
#>
Function Test-IsMacOS {
    return (Get-Variable -Name "IsMacOS" -ErrorAction "Ignore") -And $IsMacOS
}

<#
    .SYNOPSIS
    Tests if the current platform is Windows.

    .DESCRIPTION
    The "Test-IsWindows" cmdlet checks whether the "IsWindows" variable is set and returns its value.

    .EXAMPLE
    Test-IsWindows

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-IsWindows.md
#>
Function Test-IsWindows {
    return (-Not (Get-Variable -Name "IsWindows" -ErrorAction "Ignore")) -Or $IsWindows
}

Export-ModuleMember -Function *
