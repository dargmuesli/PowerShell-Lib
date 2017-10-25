Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\JavaLib.psm1" -Force

Describe "Test-JDKInstalled" {
    Context "JDK is installed" {
        Mock "Test-AppInstalled" {
            Return $True
        } -ModuleName "JavaLib"

        It "should return true" {
            Test-JDKInstalled | Should Be $True
        }
    }

    Context "JDK is not installed" {
        Mock "Test-AppInstalled" {
            Return $False
        } -ModuleName "JavaLib"

        It "should return false" {
            Test-JDKInstalled | Should Be $False
        }
    }
}

Describe "Test-JREInstalled" {
    Context "JRE is installed" {
        Mock "Test-AppInstalled" {
            Return $True
        } -ModuleName "JavaLib"

        It "should return true" {
            Test-JREInstalled | Should Be $True
        }
    }

    Context "JRE is not installed" {
        Mock "Test-AppInstalled" {
            Return $False
        } -ModuleName "JavaLib"

        It "should return false" {
            Test-JREInstalled | Should Be $False
        }
    }
}
