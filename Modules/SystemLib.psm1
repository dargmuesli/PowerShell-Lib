Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Gets the processor bit architecture.

    .DESCRIPTION
    The "Get-SystemBit" cmdlet gets the size of "IntPtr" and return either 32 or 64 accordingly.

    .EXAMPLE
    Get-SystemBit
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
