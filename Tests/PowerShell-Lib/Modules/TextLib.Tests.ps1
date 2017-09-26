Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\TextLib.psm1" -Force

Describe "Clear-Linebreaks" {
    It "removes newlines from a string" {
        Clear-Linebreaks -String "123`r`nABC`r123`n" | Should Be "123ABC123"
    }
}

Describe "Join-MultiLineStrings" {
    $MultiLineStringA = @"
123
ABC
"@
    $MultiLineStringB = @"
890
XYZ
"@

    It "joins multi line strings" {
        Join-MultiLineStrings -MultiLineStrings @($MultiLineStringA, $MultiLineStringB) | Should Be @"
123
ABC890
XYZ
"@
    }

    It "joins multi line strings with newlines" {
        Join-MultiLineStrings -MultiLineStrings @($MultiLineStringA, $MultiLineStringB) -Newline | Should Be @"
123
ABC
890
XYZ
"@
    }
}
