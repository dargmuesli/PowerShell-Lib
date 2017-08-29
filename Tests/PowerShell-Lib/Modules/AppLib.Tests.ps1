Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\AppLib.psm1" -Force

Describe "Get-AppsInstalled" {
    Context "There are apps installed" {
        Mock Get-ItemProperty {
            Return @(
                [PSCustomObject] @{
                    DisplayName = "App 1"
                },
                [PSCustomObject] @{
                    DisplayName = "App 2"
                }
            )
        } -ModuleName "AppLib"

        $GetAppsInstalled = Get-AppsInstalled

        It "should return a list of installed apps" {
            $GetAppsInstalled | Should Not BeNullOrEmpty
            $GetAppsInstalled | Should BeOfType [PSCustomObject]
        }
    }

    Context "No apps are installed" {
        Mock Get-ItemProperty {
            Return $Null
        } -ModuleName "AppLib"

        $GetAppsInstalled = Get-AppsInstalled

        It "should return a list of installed apps" {
            $GetAppsInstalled | Should BeNullOrEmpty
        }
    }
}
