Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example
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
