Set-StrictMode -Version Latest

$ValidRegexHostname = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$"
$ValidRegexIPAddress = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
$ValidRegexIRI = "/^[a-z](?:[-a-z0-9\+\.])*:(?:\/\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:])*@)?(?:\[(?:(?:(?:[0-9a-f]{1,4}:){6}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|::(?:[0-9a-f]{1,4}:){5}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){4}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:[0-9a-f]{1,4}:[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){3}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,2}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){2}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,3}[0-9a-f]{1,4})?::[0-9a-f]{1,4}:(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,4}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,5}[0-9a-f]{1,4})?::[0-9a-f]{1,4}|(?:(?:[0-9a-f]{1,4}:){0,6}[0-9a-f]{1,4})?::)|v[0-9a-f]+[-a-z0-9\._~!\$&'\(\)\*\+,;=:]+)\]|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}|(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=@])*)(?::[0-9]*)?(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|\/(?:(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*)?|(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|(?!(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])))(?:\?(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\x{E000}-\x{F8FF}\x{F0000}-\x{FFFFD}\x{100000}-\x{10FFFD}\/\?])*)?(?:\#(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\/\?])*)?$/i"
$ValidRegexPort = "^0*(?:6553[0-5]|655[0-2][0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[1-5][0-9]{4}|[1-9][0-9]{1,3}|[0-9])$"

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .PARAMETER Min
    Parameter description

    .PARAMETER Max
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-CountValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [Array] $Variable,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [Int] $Min,

        [Parameter(Mandatory = $True, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [Int] $Max
    )

    If (($Variable.Count -Ge $Min) -And ($Variable.Count -Le $Max)) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Hostname
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-HostnameValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String[]] $Hostname
    )

    ForEach ($Item In $Hostname) {
        If (-Not (Test-PatternValid -Variable $Item -Pattern $ValidRegexHostname)) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Hostname
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-IPAdressValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String[]] $IPAddress
    )

    ForEach ($Item In $IPAddress) {
        If (-Not (Test-PatternValid -Variable $Item -Pattern $ValidRegexIPAddress)) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER IRI
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-IRIValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String[]] $IRI
    )

    ForEach ($Item In $IRI) {
        If (-Not (Test-PatternValid -Variable $Item -Pattern $ValidRegexIRI)) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .PARAMETER Min
    Parameter description

    .PARAMETER Max
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-LengthValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Variable,
        
        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [Int] $Min,
        
        [Parameter(Mandatory = $True, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [Int] $Max
    )

    ForEach ($Item In $Variable) {
        $VariableLength = Measure-Object -InputObject $Item -Character

        If (($VariableLength.Characters -Lt $Min) -Or ($VariableLength.Characters -Gt $Max)) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Path
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-PathValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Path
    )

    If (Test-Path -Path $Path) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .PARAMETER Pattern
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-PatternValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Variable,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String] $Pattern
    )

    ForEach ($Item In $Variable) {
        If ($Item -CNotMatch $Pattern) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Port
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-PortValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Port
    )

    ForEach ($Item In $Port) {
        If (-Not (Test-PatternValid -Variable $Item -Pattern $ValidRegexPort)) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .PARAMETER Min
    Parameter description

    .PARAMETER Max
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-RangeValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Variable,
        
        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [Int] $Min,

        [Parameter(Mandatory = $True, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [Int] $Max
    )

    ForEach ($Item In $Variable) {
        If (($Variable -Lt $Min) -Or ($Variable -Gt $Max)) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .PARAMETER Script
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-ScriptValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Variable,
        
        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [ScriptBlock] $Script
    )

    ForEach ($Item In $Variable) {
        $PSItem = $Item

        If (-Not (& $Script)) {
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .PARAMETER Set
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-SetValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Variable,
        
        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [Array] $Set
    )

    ForEach ($Item In $Variable) {
        If (-Not $Set.Contains($Item)) {
            Return $false
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-NotNullValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [AllowNull()]
        $Variable
    )

    If ([String]::IsNullOrEmpty($Variable)) {
        Return $False
    } Else {
        ForEach ($Item In $Variable) {
            If ([String]::IsNullOrEmpty($Item)) {
                Return $False
            }
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER Variable
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-NotNullOrEmptyValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [AllowNull()]
        [AllowEmptyString()]
        [Array] $Variable
    )

    If ([String]::IsNullOrEmpty($Variable)) {
        Return $False
    } Else {
        ForEach ($Item In $Variable) {
            If ([String]::IsNullOrEmpty($Item)) {
                Return $False
            }
        }
    }

    Return $True
}

Export-ModuleMember -Function *
