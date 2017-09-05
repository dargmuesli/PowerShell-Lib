Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\DockerLib.psm1" -Force

Describe "Clear-DockerMachineEnv" {
    $MachineName = "Docker"
    $EnvExists = Test-DockerMachineEnvExists

    If (-Not $EnvExists) {
        Set-DockerMachineEnv -MachineName $MachineName
    }

    It "should clear the docker machine environment variables" {
        Clear-DockerMachineEnv -MachineName $MachineName | Should BeNullOrEmpty
        Test-DockerMachineEnvExists | Should Be $False
    }

    If ($EnvExists) {
        Set-DockerMachineEnv -MachineName $MachineName
    }
}

Describe "Get-DockerEditionToUse" {
    Context "only Docker for Windows is installed" {
        Mock Test-DockerForWinInstalled {
            Return $True
        } -ModuleName "DockerLib"

        Mock Test-DockerToolboxInstalled {
            Return $False
        } -ModuleName "DockerLib"

        It "should return `"ForWin`"" {
            Get-DockerEditionToUse | Should Be "ForWin"
        }
    }

    Context "only Docker Toolbox is installed" {
        Mock Test-DockerForWinInstalled {
            Return $False
        } -ModuleName "DockerLib"

        Mock Test-DockerToolboxInstalled {
            Return $True
        } -ModuleName "DockerLib"

        It "should return `"Toolbox`"" {
            Get-DockerEditionToUse | Should Be "Toolbox"
        }
    }

    Context "Docker for Windows and Docker Toolbox are installed" {
        Mock Test-DockerForWinInstalled {
            Return $True
        } -ModuleName "DockerLib"

        Mock Test-DockerToolboxInstalled {
            Return $True
        } -ModuleName "DockerLib"

        It "should return `"ForWin`" as first choice" {
            Mock Read-Prompt {
                Return "0"
            } -ModuleName "DockerLib"

            Get-DockerEditionToUse | Should Be "ForWin"
        }

        It "should return `"Toolbox`" as second choice" {
            Mock Read-Prompt {
                Return "1"
            } -ModuleName "DockerLib"

            Get-DockerEditionToUse | Should Be "Toolbox"
        }
    }
}

Describe "Get-DockerMachineStatus" {
    Mock Invoke-DockerMachine {
        Return "Running"
    } -ModuleName "DockerLib"

    It "should return docker machine status" {
        Get-DockerMachineStatus -MachineName "Docker" | Should Be "Running"
    }
}

Describe "Install-Docker" {
    Mock Get-FileFromWeb {} -ModuleName "DockerLib"
    Mock Install-App {} -ModuleName "DockerLib"

    It "should install Docker" {
        Install-Docker | Should BeNullOrEmpty
    }
}

Describe "Invoke-DockerMachine" {
    Context "Docker machine command does not exist" {
        Mock Test-DockerMachineCommand {
            Return $False
        } -ModuleName "DockerLib"

        It "should throw an error" {
            {Invoke-DockerMachine} | Should Throw "Command `"docker-machine`" not found."
        }
    }
}
