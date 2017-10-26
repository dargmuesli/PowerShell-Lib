Set-StrictMode -Version Latest

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

Export-ModuleMember -Function *
