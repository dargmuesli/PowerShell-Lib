Set-StrictMode -Version Latest

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