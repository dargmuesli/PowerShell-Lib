Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\DockerLib.psm1" -Force

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

Describe "Invoke-Docker" {
    Context "Docker command does not exist" {
        Mock Test-Command {
            Return $False
        } -ModuleName "DockerLib"

        It "should throw an error" {
            {Invoke-Docker} | Should Throw
        }
    }

    Context "Docker is not running" {
        Mock Test-DockerRunning {
            Return $False
        } -ModuleName "DockerLib"

        It "should throw an error" {
            {Invoke-Docker} | Should Throw
        }
    }
}

Describe "Invoke-DockerMachine" {
    Context "Docker machine command does not exist" {
        Mock Test-Command {
            Return $False
        } -ModuleName "DockerLib"

        It "should throw an error" {
            {Invoke-DockerMachine} | Should Throw
        }
    }
}

Describe "Test-DockerForWinInstalled" {
    Context "Docker for Windows is installed" {
        Mock "Test-AppInstalled" {
            Return $True
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerForWinInstalled | Should Be $True
        }
    }

    Context "Docker for Windows is not installed" {
        Mock "Test-AppInstalled" {
            Return $False
        } -ModuleName "DockerLib"

        It "should return false" {
            Test-DockerForWinInstalled | Should Be $False
        }
    }
}

Describe "Test-DockerInstalled" {
    Context "Neither Docker for Windows nor Docker Machine are installed" {
        Mock "Test-DockerForWinInstalled" {
            Return $False
        } -ModuleName "DockerLib"

        Mock "Test-DockerToolboxInstalled" {
            Return $False
        } -ModuleName "DockerLib"

        It "should return false" {
            Test-DockerInstalled | Should Be $False
        }
    }

    Context "Only Docker for Windows is installed" {
        Mock "Test-DockerForWinInstalled" {
            Return $True
        } -ModuleName "DockerLib"

        Mock "Test-DockerToolboxInstalled" {
            Return $False
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerInstalled | Should Be $True
        }
    }

    Context "Only Docker Machine is installed" {
        Mock "Test-DockerForWinInstalled" {
            Return $False
        } -ModuleName "DockerLib"

        Mock "Test-DockerToolboxInstalled" {
            Return $True
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerInstalled | Should Be $True
        }
    }

    Context "Docker for Windows and Docker Machine are installed" {
        Mock "Test-DockerForWinInstalled" {
            Return $True
        } -ModuleName "DockerLib"

        Mock "Test-DockerToolboxInstalled" {
            Return $True
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerInstalled | Should Be $True
        }
    }
}

Describe "Test-DockerInSwarm" {
    Context "Docker is in swarm" {
        Mock "Invoke-ExpressionSafe" {
            Return "Already in swarm"
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerInSwarm | Should Be $True
        }
    }

    Context "Docker is not in swarm" {
        Mock "Invoke-ExpressionSafe" {
            Return "Swarm initialized"
        } -ModuleName "DockerLib"

        It "should return false" {
            Test-DockerInSwarm | Should Be $False
        }
    }
}

Describe "Test-DockerMachineEnvExists" {
    Context "Docker environment variables do exist" {
        Mock "Get-ChildItem" {
            Return $True
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerMachineEnvExists | Should Be $True
        }
    }

    Context "Docker environment variables do not exist" {
        Mock "Get-ChildItem" {
            Return $False
        } -ModuleName "DockerLib"

        It "should return false" {
            Test-DockerMachineEnvExists | Should Be $False
        }
    }
}

Describe "Test-DockerRegistryRunning" {
    $Hostname = "localhost"
    $Port = 5000

    Context "Docker registry is running" {
        Mock "Invoke-ExpressionSafe" {
            Return $True
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerRegistryRunning -Hostname $Hostname -Port $Port | Should Be $True
        }
    }

    Context "Docker registry is not running" {
        Mock "Invoke-ExpressionSafe" {
            Return $False
        } -ModuleName "DockerLib"

        It "should return false" {
            Test-DockerRegistryRunning -Hostname $Hostname -Port $Port | Should Be $False
        }
    }
}

Describe "Test-DockerRunning" {
    Context "Docker is running" {
        Mock "Invoke-ExpressionSafe" {
            Return $True
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerRunning | Should Be $True
        }
    }

    Context "Docker is not running" {
        Mock "Invoke-ExpressionSafe" {
            Return $Null
        } -ModuleName "DockerLib"

        It "should return false for null" {
            Test-DockerRunning | Should Be $False
        }
    }
}

Describe "Test-DockerToolboxInstalled" {
    Context "Docker Toolbox is installed" {
        Mock "Test-AppInstalled" {
            Return $True
        } -ModuleName "DockerLib"

        It "should return true" {
            Test-DockerToolboxInstalled | Should Be $True
        }
    }

    Context "Docker Toolbox is not installed" {
        Mock "Test-AppInstalled" {
            Return $False
        } -ModuleName "DockerLib"

        It "should return false" {
            Test-DockerToolboxInstalled | Should Be $False
        }
    }
}
