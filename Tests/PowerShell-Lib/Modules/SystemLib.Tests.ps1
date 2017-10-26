Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\SystemLib.psm1" -Force

Describe "Get-DownloadFolder" {
    Context "Windows 10 and above" {
        Mock "Get-OsVersion" {
            Return New-Object "System.Version" "8.0.0.0"
        } -ModuleName "SystemLib"

        Mock "Get-ItemPropertyValue" {
            Return "C:\Downloads"
        } -ModuleName "SystemLib"

        It "should return download folder" {
            Get-DownloadFolder | Should Be "C:\Downloads"
        }
    }

    Context "Below Windows 10" {
        Mock "Get-OsVersion" {
            Return New-Object "System.Version" "10.0.0.0"
        } -ModuleName "SystemLib"

        Mock "Get-ItemPropertyValue" {
            Return "C:\Downloads"
        } -ModuleName "SystemLib"

        It "should return false" {
            Get-DownloadFolder | Should Be "C:\Downloads"
        }
    }
}
