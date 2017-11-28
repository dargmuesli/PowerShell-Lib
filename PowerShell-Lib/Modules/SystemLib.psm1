Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Gets available exceptions.

    .DESCRIPTION
    The "Get-AvailableExceptions" cmdlet iterates over and filters exceptions so that it returns a list of available excetions.

    .EXAMPLE
    Get-AvailableException

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Get-AvailableExceptions.md

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
    Returns the user's download folder.

    .DESCRIPTION
    The "Get-DownloadFolder" cmdlet returns the value of a OS version dependent registry value.

    .EXAMPLE
    Get-DownloadFolder

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Get-DownloadFolder.md
#>
Function Get-DownloadFolder {
    $UserShellFoldersPath = "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"

    If ((Get-OsVersion).Major -Lt 10) {
        Return Get-ItemPropertyValue -Path $UserShellFoldersPath -Name "{374DE290-123F-4565-9164-39C4925E467B}"
    } Else {
        Return Get-ItemPropertyValue -Path $UserShellFoldersPath -Name "{7D83EE9B-2244-4E70-B1F5-5393042AF1E4}"
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
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Get-OsVersion.md
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
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Get-SystemBit.md
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
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-AdminPermissions.md
#>
Function Test-AdminPermissions {
    If (([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        Return $True
    } Else {
        Return $False
    }
}

Export-ModuleMember -Function *
