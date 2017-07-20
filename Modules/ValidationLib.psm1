Set-StrictMode -Version Latest

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
        [Parameter(Mandatory = $True)] [Array] $Variable,
        [Parameter(Mandatory = $True)] [Int] $Min,
        [Parameter(Mandatory = $True)] [Int] $Max
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
        [Parameter(Mandatory = $True)] $Variable,
        [Parameter(Mandatory = $True)] [Int] $Min,
        [Parameter(Mandatory = $True)] [Int] $Max
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

    .PARAMETER Variable
    Parameter description

    .PARAMETER Pattern
    Parameter description

    .EXAMPLE
    An example
#>
Function Test-PatternValid {
    Param (
        [Parameter(Mandatory = $True)] $Variable,
        [Parameter(Mandatory = $True)] [String] $Pattern
    )

    ForEach ($Item In $Variable) {
        If ($Item -NotLike $Pattern) {
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
        [Parameter(Mandatory = $True)] $Variable,
        [Parameter(Mandatory = $True)] [Int] $Min,
        [Parameter(Mandatory = $True)] [Int] $Max
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
        [Parameter(Mandatory = $True)] $Variable,
        [Parameter(Mandatory = $True)] [ScriptBlock] $Script
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
        [Parameter(Mandatory = $True)] $Variable,
        [Parameter(Mandatory = $True)] [Array] $Set
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
        [Parameter(Mandatory = $True)] [AllowNull()] $Variable
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
        [Parameter(Mandatory = $True)] [AllowNull()] [AllowEmptyString()] [Array] $Variable
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
