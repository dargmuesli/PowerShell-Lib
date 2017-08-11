Set-StrictMode -Version Latest

$ValidRegexHostname = "^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$"
$ValidRegexIPAddress = "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"
$ValidRegexIRI = "/^[a-z](?:[-a-z0-9\+\.])*:(?:\/\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:])*@)?(?:\[(?:(?:(?:[0-9a-f]{1,4}:){6}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|::(?:[0-9a-f]{1,4}:){5}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){4}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:[0-9a-f]{1,4}:[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){3}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,2}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:){2}(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,3}[0-9a-f]{1,4})?::[0-9a-f]{1,4}:(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,4}[0-9a-f]{1,4})?::(?:[0-9a-f]{1,4}:[0-9a-f]{1,4}|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3})|(?:(?:[0-9a-f]{1,4}:){0,5}[0-9a-f]{1,4})?::[0-9a-f]{1,4}|(?:(?:[0-9a-f]{1,4}:){0,6}[0-9a-f]{1,4})?::)|v[0-9a-f]+[-a-z0-9\._~!\$&'\(\)\*\+,;=:]+)\]|(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(?:\.(?:[0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}|(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=@])*)(?::[0-9]*)?(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|\/(?:(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*)?|(?:(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))+)(?:\/(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@]))*)*|(?!(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])))(?:\?(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\x{E000}-\x{F8FF}\x{F0000}-\x{FFFFD}\x{100000}-\x{10FFFD}\/\?])*)?(?:\#(?:(?:%[0-9a-f][0-9a-f]|[-a-z0-9\._~\x{A0}-\x{D7FF}\x{F900}-\x{FDCF}\x{FDF0}-\x{FFEF}\x{10000}-\x{1FFFD}\x{20000}-\x{2FFFD}\x{30000}-\x{3FFFD}\x{40000}-\x{4FFFD}\x{50000}-\x{5FFFD}\x{60000}-\x{6FFFD}\x{70000}-\x{7FFFD}\x{80000}-\x{8FFFD}\x{90000}-\x{9FFFD}\x{A0000}-\x{AFFFD}\x{B0000}-\x{BFFFD}\x{C0000}-\x{CFFFD}\x{D0000}-\x{DFFFD}\x{E1000}-\x{EFFFD}!\$&'\(\)\*\+,;=:@])|[\/\?])*)?$/i"
$ValidRegexPort = "^0*(?:6553[0-5]|655[0-2][0-9]|65[0-4][0-9]{2}|6[0-4][0-9]{3}|[1-5][0-9]{4}|[1-9][0-9]{1,3}|[0-9])$"

<#
    .SYNOPSIS
    Checks whether the count of a variable's values is in a specified range.

    .DESCRIPTION
    The "Test-CountValid" cmdlet checks if the count of a variable's values is in a specified range and returns true on success.

    .PARAMETER Variable
    The variable that is to be checked.

    .PARAMETER Min
    The minimum count to allow.

    .PARAMETER Max
    The maximum count to allow.

    .EXAMPLE
    Test-CountValid -Variable @(@(1, 2), @(3, 4)) -Min 0 -Max 2

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-CountValid.md
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
    Checks whether a hostname is valid.

    .DESCRIPTION
    The "Test-HostnameValid" cmdlet tries to match a hostname with a regex pattern for valid hostnames and returns true on success.

    .PARAMETER Hostname
    The hostname that is to be checked.

    .EXAMPLE
    Test-HostnameValid -Hostname "test-hostname"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-HostnameValid.md
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
    Checks whether an IP address is valid.

    .DESCRIPTION
    The "Test-IPAddressValid" cmdlet tries to match an IP address with a regex pattern for valid IP addresses and returns true on success.

    .PARAMETER IPAddress
    The IP address that is to be checked.

    .EXAMPLE
    Test-IPAddressValid -IPAddress "127.0.0.1"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-IPAddressValid.md
#>
Function Test-IPAddressValid {
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
    Checks whether an IRI is valid.

    .DESCRIPTION
    The "Test-IRIValid" cmdlet tries to match an IRI with a regex pattern for valid IRIs and returns true on success.

    .PARAMETER IRI
    The IRI that is to be checked.

    .EXAMPLE
    Test-IRIValid -IRI "google.com"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-IRIValid.md
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
    Checks whether the length of a variable's values is in a specified range.

    .DESCRIPTION
    The "Test-LengthValid" cmdlet checks if the length of a variable's values is in a specified range and returns true on success.

    .PARAMETER Variable
    The variable that is to be checked.

    .PARAMETER Min
    The minimum value to allow.

    .PARAMETER Max
    The maximum value to allow.

    .EXAMPLE
    Test-LengthValid -Variable @("123", "456") -Min 0 -Max 3

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-LengthValid.md
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
    Check if a variable is not null.

    .DESCRIPTION
    The "Test-NotNullValid" cmdlet checks if a variable's values are not null and returns true on success.

    .PARAMETER Variable
    The variable that is to be checked.

    .EXAMPLE
    Test-NotNullValid -Variable @(123)

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-NotNullValid.md
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
    Check if a variable is not null and not empty.

    .DESCRIPTION
    The "Test-NotNullOrEmptyValid" cmdlet checks if a variable's values are not null or empty and returns true on success.

    .PARAMETER Variable
    The variable that is to be checked.

    .EXAMPLE
    Test-NotNullOrEmptyValid -Variable @(123)

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-NotNullOrEmptyValid.md
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

<#
    .SYNOPSIS
    Checks whether a path is valid.

    .DESCRIPTION
    The "Test-PathValid" cmdlet checks if a path is valid and returns true on success.

    .PARAMETER Path
    The path that is to be checked.

    .EXAMPLE
    Test-PathValid -Path ".\"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-PathValid.md
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
    Checks whether a pattern is valid.

    .DESCRIPTION
    The "Test-PatternValid" cmdlet checks if a pattern is valid and returns true on success.

    .PARAMETER Variable
    The variable that is to be checked with a pattern.

    .PARAMETER Pattern
    The regex pattern that the variable is checked against.

    .EXAMPLE
    Test-PatternValid -Variable "123 ABC" -Pattern "^[0-9]*\s[A-Z]*$"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-PatternValid.md
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
    Checks whether a port is valid.

    .DESCRIPTION
    The "Test-PortValid" cmdlet tries to match a port with a regex pattern for valid ports and returns true on success.

    .PARAMETER Port
    The port that is to be checked.

    .EXAMPLE
    Test-PortValid -Port "8080"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-PortValid.md
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
    Checks whether a variable's values are in a specified range.

    .DESCRIPTION
    The "Test-CountValid" cmdlet checks if a variable's values are in a specified range and returns true on success.

    .PARAMETER Variable
    The variable that is to be checked.

    .PARAMETER Min
    The minimum value to allow.

    .PARAMETER Max
    The maximum value to allow.

    .EXAMPLE
    Test-RangeValid -Variable @(1, 2, 3) -Min 0 -Max 3

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-RangeValid.md
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
    Checks whether a script validifies a variable's values.

    .DESCRIPTION
    The "Test-ScriptValid" cmdlet checks if a script validifies a variable's values and returns true on success.

    .PARAMETER Variable
    The variable that is to be checked.

    .PARAMETER Script
    The script that checks the variable.

    .EXAMPLE
    Test-ScriptValid -Variable @(5) -Script "If ($PSItem = 5) { Return $True } Else { Return $False }"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-ScriptValid.md
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
    Checks whether a variable's values exist within a set.

    .DESCRIPTION
    The "Test-SetValid" cmdlet checks if a variable's values exist within a set and return true on success.

    .PARAMETER Variable
    The variable that is to be checked.

    .PARAMETER Set
    The set that contains the variables that are allowed to appear within the variable.

    .EXAMPLE
    Test-SetValid -Variable @("test", "123") -Set @("test", "123", "foo", "bar")

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-SetValid.md
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
            Return $False
        }
    }

    Return $True
}

<#
    .SYNOPSIS
    Checks whether a variable's values are of a given type.

    .DESCRIPTION
    The "Test-TypeValid" cmdlet checks if a variable's values are of a given type and returns true on succcess.

    .PARAMETER Variable
    The variable that is to be checked.

    .PARAMETER Type
    The type of which the variable's values have to be of.

    .EXAMPLE
    Test-TypeValid -Variable @(123) -Type Int

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-TypeValid.md
#>
Function Test-TypeValid {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Variable,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String] $Type
    )

    ForEach ($Item In $Variable) {
        If ($Variable -IsNot $Type) {
            Return $False
        }
    }

    Return $True
}

Export-ModuleMember -Function *
