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

Describe "Install-App" {
    $InstallerPathExe = "TestDrive:\x.exe"
    $InstallerPathMsi = "TestDrive:\x.msi"

    New-Item -Path $InstallerPathExe -ItemType "File"
    New-Item -Path $InstallerPathMsi -ItemType "File"

    Context "exe" {
        Mock Start-Process {} -ModuleName "AppLib"

        It "should give no feedback" {
            Install-App -InstallerPath $InstallerPathExe | Should BeNullOrEmpty
        }
    }

    Context "msi" {
        Mock Start-Process {} -ModuleName "AppLib"

        It "should give no feedback" {
            Install-App -InstallerPath $InstallerPathMsi | Should BeNullOrEmpty
        }
    }

    Context "default" {
        $InstallerPath = "~"

        It "should throw an error" {
            {Install-App -InstallerPath $InstallerPath} | Should Throw "File extension of `"$InstallerPath`" is neither `".exe`" nor `".msi`"."
        }
    }
}

Describe "Test-AppInstalled" {
    $AppName = "TestApp-123"
    $AppNameRegex = "^TestApp-123$"

    Context "app installed" {
        Mock Get-AppsInstalled {
            Return @(
                @{
                    "DisplayName" = "TestApp-123"
                }
            )
        } -ModuleName "AppLib"

        It "should return true for an installed app" {
            Test-AppInstalled -AppName $AppName | Should Be $True
            Test-AppInstalled -AppName $AppNameRegex -RegexCompare | Should Be $True
        }
    }

    Context "app not installed" {
        Mock Get-AppsInstalled {
            Return @(
                @{}
            )
        } -ModuleName "AppLib"

        It "should return false for a not installed app" {
            Test-AppInstalled -AppName $AppName | Should Be $False
            Test-AppInstalled -AppName $AppNameRegex -RegexCompare | Should Be $False
        }
    }
}
