Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\SystemLib.psm1" -Force

Describe "Get-DefaultPackageManager" {
    Context "Linux" {
        Mock "Test-IsLinux" {
            Return $True
        } -ModuleName "SystemLib"

        Context "Arch Linux" {
            Mock "Get-LinuxOsId" {
                Return "arch"
            } -ModuleName "SystemLib"

            Get-DefaultPackageManager | Should Be "Pacman"
        }
    }
}

Describe "Get-DownloadFolder" {
    Context "Windows" {
        Mock "Test-IsLinux" {
            Return $False
        } -ModuleName "SystemLib"

        Mock "Test-IsWindows" {
            Return $True
        } -ModuleName "SystemLib"

        Context "10 and above" {
            Mock "Get-OsVersion" {
                Return New-Object "System.Version" "10.0.0.0"
            } -ModuleName "SystemLib"

            Mock "Get-ItemPropertyValue" {
                Return "C:\Downloads"
            } -ModuleName "SystemLib"

            It "should return download folder" {
                Get-DownloadFolder | Should Be "C:\Downloads"
            }
        }

        Context "Below 10" {
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
    }

    Context "Linux" {
        Mock "Test-IsLinux" {
            Return $True
        } -ModuleName "SystemLib"

        Mock "Test-IsWindows" {
            Return $False
        } -ModuleName "SystemLib"

        Context "Below Windows 10" {
            Mock "Invoke-Expression" {
                Return "/home/user/Downloads"
            } -ModuleName "SystemLib"

            It "should return download folder" {
                Get-DownloadFolder | Should Be "/home/user/Downloads"
            }
        }
    }
}

Describe "Get-EOLCharacter" {
    Context "Windows" {
        Mock "Test-IsWindows" {
            Return $True
        } -ModuleName "SystemLib"

        Mock "Test-IsLinux" {
            Return $False
        } -ModuleName "SystemLib"

        Mock "Test-IsMacOS" {
            Return $False
        } -ModuleName "SystemLib"

        It "should return Windows EOL character" {
            Get-EOLCharacter | Should Be "`r`n"
        }
    }

    Context "Linux" {
        Mock "Test-IsWindows" {
            Return $False
        } -ModuleName "SystemLib"

        Mock "Test-IsLinux" {
            Return $True
        } -ModuleName "SystemLib"

        Mock "Test-IsMacOS" {
            Return $False
        } -ModuleName "SystemLib"

        It "should return Linux EOL character" {
            Get-EOLCharacter | Should Be "`n"
        }
    }

    Context "MacOS" {
        Mock "Test-IsWindows" {
            Return $False
        } -ModuleName "SystemLib"

        Mock "Test-IsLinux" {
            Return $False
        } -ModuleName "SystemLib"

        Mock "Test-IsMacOS" {
            Return $True
        } -ModuleName "SystemLib"

        It "should return MacOS EOL character" {
            Get-EOLCharacter | Should Be "`r"
        }
    }
}
