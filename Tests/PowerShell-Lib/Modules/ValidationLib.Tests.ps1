Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\ValidationLib.psm1" -Force

Describe "Test-CountValid" {
    It "checks whether the count of a variable's values is in a specified range" {
        Test-CountValid -Variable @(@(1), @(2)) -Min 0 -Max 2 | Should Be $True
        Test-CountValid -Variable @(@(3, 4), @(5, 6, 7)) -Min 0 -Max 2 | Should Be $False
    }
}

Describe "Test-HostnameValid" {
    It "checks whether a hostname is valid" {
        Test-HostnameValid -Hostname @("localhost", "local-host", "local.host") | Should Be $True
        Test-HostnameValid -Hostname @("localhost", "local+host") | Should Be $False
    }
}

Describe "Test-IPAddressValid" {
    It "checks whether an IP address is valid" {
        Test-IPAddressValid -IPAddress @("127.0.0.1", "192.168.178.1") | Should Be $True
        Test-IPAddressValid -IPAddress @("127.0.0.1", "localhost") | Should Be $False
    }
}

Describe "Test-IRIValid" {
    It "checks whether an IRI is valid" {
        Test-IRIValid -IRI @("www.test.com", "test.com") | Should Be $True
        Test-IRIValid -IRI @("test.com", "localhost") | Should Be $False
    }
}

Describe "Test-LengthValid" {
    It "checks whether the length of a variable's values is in a specified range" {
        Test-LengthValid -Variable @("12", "345") -Min 0 -Max 3 | Should Be $True
        Test-LengthValid -Variable @("6789", "0") -Min 0 -Max 3 | Should Be $False
    }
}

Describe "Test-NotNullOrEmptyValid" {
    It "checks if a variable is not null and not empty" {
        Test-NotNullOrEmptyValid -Variable $Null | Should Be $False
        Test-NotNullOrEmptyValid -Variable "" | Should Be $False
        Test-NotNullOrEmptyValid -Variable @("ABC", $Null) | Should Be $False
        Test-NotNullOrEmptyValid -Variable @("ABC", "") | Should Be $False
        Test-NotNullOrEmptyValid -Variable @("ABC", "123") | Should Be $True
    }
}

Describe "Test-NotNullValid" {
    It "checks if a variable is not null" {
        Test-NotNullValid -Variable $Null | Should Be $False
        Test-NotNullValid -Variable "" | Should Be $True
        Test-NotNullValid -Variable @("ABC", $Null) | Should Be $False
        Test-NotNullValid -Variable @("ABC", "") | Should Be $True
        Test-NotNullValid -Variable @("ABC", "123") | Should Be $True
    }
}

Describe "Test-PathValid" {
    It "checks whether a path is valid" {
        Test-PathValid -Path @("C:\", "C:\ABC") | Should Be $True
        Test-PathValid -Path @("C:\", "C::\") | Should Be $False
    }
}

Describe "Test-PatternValid" {
    $Pattern = "^123.*$"

    It "checks whether a pattern is valid" {
        Test-PatternValid -Variable @("123", "123ABC") -Pattern $Pattern | Should Be $True
        Test-PatternValid -Variable @("123ABC", "ABC123") -Pattern $Pattern | Should Be $False
    }
}

Describe "Test-PortValid" {
    It "checks whether a port is valid" {
        Test-PortValid -Port @("123", "8080") | Should Be $True
        Test-PortValid -Port @("8080", "abc") | Should Be $False
    }
}

Describe "Test-RangeValid" {
    It "checks whether a variable's values are in a specified range" {
        Test-RangeValid -Variable @("1", "2") -Min 0 -Max 2 | Should Be $True
        Test-RangeValid -Variable @("2", "3") -Min 0 -Max 2 | Should Be $False
    }
}

Describe "Test-ScriptValid" {
    $Script = {If ($Args[0] -Eq 5) { Return $True } Else { Return $False }}

    It "checks whether a script validifies a variable's values" {
        Test-ScriptValid -Variable @(5, 5) -Script $Script | Should Be $True
        Test-ScriptValid -Variable @(5, 6) -Script $Script | Should Be $False
    }
}

Describe "Test-SetValid" {
    It "checks whether a variable's values exist within a set" {
        Test-SetValid -Variable @("test", "123") -Set @("test", "123") | Should Be $True
        Test-SetValid -Variable @("test", "ABC") -Set @("test", "123") | Should Be $False
    }
}

Describe "Test-TypeValid" {
    It "checks whether a variable's values are of a given type" {
        Test-TypeValid -Variable @(123, 345) -Type "Int" | Should Be $True
        Test-TypeValid -Variable @(123, "ABC") -Type "Int" | Should Be $False
    }
}
