Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MachineName
    Parameter description

    .EXAMPLE
    An example
#>
Function Clear-DockerMachineEnv {
    If (-Not (Test-DockerMachineCommand)) {
        Throw "Command `"docker-machine`" not found."
    }

    Write-Debug -Message "Clearing environment variables..."
    docker-machine env --shell=powershell --unset | Invoke-Expression
}


Function Get-DockerEditionToUse {
    $DockerForWinInstalled = Test-DockerForWinInstalled
    $DockerToolboxInstalled = Test-DockerToolboxInstalled

    If ($DockerForWinInstalled -And $DockerToolboxInstalled) {
        $Choices = [Management.Automation.Host.ChoiceDescription[]] (
            (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList 'Docker for Windows'),
            (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList 'Docker Toolbox')
        )

        $Decision = Read-Prompt -Caption "Docker for Windows and Docker Toolbox are installed." -Message "Which one do you want to use?" -Choices $Choices -DefaultChoice 0

        Switch ($Decision) {
            0 {
                Return "ForWin"
                Break
            }
            1 {
                Return "Toolbox"
                Break
            }
        }
    } ElseIf ($DockerForWinInstalled) {
        Return "ForWin"
    } ElseIf ($DockerToolboxInstalled) {
        Return "Toolbox"
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MachineName
    Parameter description

    .EXAMPLE
    An example
#>
Function Get-DockerMachineStatus {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    If (-Not (Test-DockerMachineCommand)) {
        Throw "Command `"docker-machine`" not found."
    }

    docker-machine status $MachineName
}

<#
    .SYNOPSIS
    Installs Docker.

    .DESCRIPTION
    Downloads and starts the docker installer.

    .PARAMETER DownloadMethod
    Indicates which type of download function is to be used.

    .EXAMPLE
    Install-Docker
#>
Function Install-Docker {
    Param (
        [Parameter(Mandatory = $False)]
        [ValidateSet('ForWin', 'Toolbox')]
        [String] $Edition = "ForWin",

        [Parameter(Mandatory = $False)]
        [ValidateSet('BITS', 'WebClient', 'WebRequest')]
        [String] $DownloadMethod = "BITS"
    )

    Switch ($Edition) {
        "ForWin" {
            $RemoteFilename = "InstallDocker.msi"
            $Path = "$Env:Temp\$RemoteFilename"

            Get-FileFromWeb -URL "https://download.docker.com/win/stable/$RemoteFilename" -LocalPath $Path -DownloadMethod $DownloadMethod
            Install-App -InstallerPath $Path -InstallerType "msi"
            Break
        }
        "Toolbox" {
            $RemoteFilename = "DockerToolbox.exe"
            $Path = "$Env:Temp\$RemoteFilename"

            Get-FileFromWeb -URL "https://download.docker.com/win/stable/$RemoteFilename" -LocalPath $Path -DownloadMethod $DownloadMethod
            Install-App -InstallerPath $Path
            Break
        }
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MachineName
    Parameter description

    .EXAMPLE
    An example
#>
Function New-DockerMachine {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    If (-Not (Test-DockerMachineCommand)) {
        Throw "Command `"docker-machine`" not found."
    }

    Write-Debug "Creating machine `"$MachineName`" in VirtualBox..."
    docker-machine rm -f $MachineName | Out-Null
    docker-machine create -d virtualbox --virtualbox-memory 2048 $MachineName
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MachineName
    Parameter description

    .EXAMPLE
    An example
#>
Function Set-DockerMachineEnv {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    If (-Not (Test-DockerMachineCommand)) {
        Throw "Command `"docker-machine`" not found."
    }

    Write-Debug -Message "Setting environment variables for machine `"$MachineName`"..."
    docker-machine env --shell=powershell $MachineName | Invoke-Expression
}

<#
    .SYNOPSIS
    Starts Docker for Windows.

    .DESCRIPTION
    Checks if Docker is installed, how it is installed and if it is running. If not it offers to install and start Docker automatically.

    .EXAMPLE
    Start-Docker

    .NOTES
    https://gist.github.com/au-phiware/25213e72c80040f398ba
#>
Function Start-Docker {
    Param (
        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName = "Docker",

        [Parameter(Mandatory = $False)]
        [ValidateSet('BITS', 'WebClient', 'WebRequest')]
        [String] $DownloadMethod = "BITS"
    )

    While (-Not (Test-DockerInstalled)) {
        If (Read-PromptYesNo -Caption "Docker is not installed." -Message "Do you want to install it automatically?" -DefaultChoice 0) {
            Install-Docker -DownloadMethod $DownloadMethod
        } Else {
            Read-Host "Please install Docker manually. Press enter to continue..."
        }
    }

    If (-Not (Test-DockerRunning)) {
        Switch (Get-DockerEditionToUse) {
            "ForWin" {
                $DockerPath = (Get-Command docker).Path

                If ($DockerPath -And (Read-PromptYesNo -Caption "Docker is not running." -Message "Do you want to start it automatically?" -DefaultChoice 0)) {
                    If ($DockerPath) {
                        & "$((Get-Item $DockerPath).Directory.Parent.Parent.FullName)\Docker for Windows.exe"
                    }

                    Wait-Test -Test "-Not (Test-DockerRunning)" -Activity "Waiting for Docker to initialize" -WithProgressbar
                    Break
                } Else {
                    Read-Host "Please start Docker manually. Press enter to continue..."
                }

                Break
            }
            "Toolbox" {
                If (-Not (Test-DockerMachineCommand)) {
                    Throw "Command `"docker-machine`" not found."
                }

                If (-Not (Test-DockerMachineExists -MachineName $MachineName)) {
                    New-DockerMachine -MachineName $MachineName
                }

                If ((Get-DockerMachineStatus -MachineName $MachineName) -Ne "Running") {
                    Start-DockerMachine -MachineName $MachineName
                }

                $MountOptions = "defaults,iocharset=utf8"
                $DockerPasswd = & docker-machine ssh $MachineName "grep '^docker:' /etc/passwd"

                If ($DockerPasswd.StartsWith('docker:')) {
                    $MountOptions = "$MountOptions,$($DockerPasswd -replace '^docker:[^:]*:(\d+):(\d+):.*$', 'uid=$1,gid=$2')"
                }

                $VirtualBoxMounts = & docker-machine ssh $MachineName mount |
                    ForEach-Object {
                    If ($PSItem -Match 'on (.*) type vboxsf ') {
                        $Matches[1]
                    }
                }

                & docker-machine ssh $MachineName "sudo VBoxControl sharedfolder list -automount" |
                    ForEach-Object {
                    If ($PSItem -Match '^[0-9]+ - (?<ShareName>((?<DriveLetter>[A-Za-z]):)?(?<FolderName>.*))$') {
                        $MountPoint = "$($Matches['DriveLetter'])$($Matches['FolderName'])"

                        If (-Not ($MountPoint -Match '^/')) {
                            $MountPoint = "/$MountPoint"
                        }

                        If (-Not ($VirtualBoxMounts -CContains $MountPoint)) {
                            Write-Output "Mounting $($Matches['ShareName']) to $MountPoint..."

                            & docker-machine ssh $MachineName "sudo mkdir -p $MountPoint && sudo mount -t vboxsf -o $MountOptions $($Matches['ShareName']) $MountPoint"
                        }
                    }
                }

                Remove-Variable MountOptions, DockerPasswd, VirtualBoxMounts, MountPoint
                Set-DockerMachineEnv -MachineName $MachineName

                Wait-Test -Test "-Not (Test-DockerRunning)" -Activity "Waiting for Docker to initialize" -WithProgressbar
                Break
            }
        }

        Write-Output @"
                            ##         .
                    ## ## ##        ==
                ## ## ## ## ##    ===
            /"""""""""""""""""\___/ ===
        ~~~ {~~ ~~~~ ~~~ ~~~~ ~~~ ~ /  ===- ~~~
            \______ o           __/
                \    \         __/
                \____\_______/

                Docker started.
"@
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MachineName
    Parameter description

    .EXAMPLE
    An example
#>
Function Start-DockerMachine {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    If (-Not (Test-DockerMachineCommand)) {
        Throw "Command `"docker-machine`" not found."
    }

    Write-Debug "Starting machine $MachineName..."
    docker-machine start $MachineName
}

<#
    .SYNOPSIS
    Starts a registry container in Docker.

    .DESCRIPTION
    Tries to start the Docker registry image and offers to install it in case it is not.

    .PARAMETER Name
    The container's name

    .PARAMETER Hostname
    The hostname on which the registry should be available.

    .PARAMETER Port
    The port on which the registry should be available.

    .EXAMPLE
    Start-DockerRegistry -Name $RegistryAddressName -Host $RegistryAddressHostname -Port $RegistryAddressPort
#>
Function Start-DockerRegistry {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $RegistryName,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateScript({Test-HostnameValid -Hostname $PSItem})]
        [String] $Hostname,

        [Parameter(Mandatory = $True, Position = 2)]
        [ValidateScript({Test-PortValid -Port $PSItem})]
        [String] $Port
    )

    While (-Not (Test-DockerRegistryRunning -Hostname $Hostname -Port $Port)) {
        $DockerInspectConfigHostname = docker inspect -f "{{.Config.Hostname}}" $RegistryName |
            Out-String |
            ForEach-Object {
            If ($PSItem) {
                Clear-Linebreaks -String $PSItem
            }
        }

        If ($DockerInspectConfigHostname -And ($DockerInspectConfigHostname -Match "^[a-z0-9] {12}$")) {
            docker start $DockerInspectConfigHostname
        } Else {
            If (Read-PromptYesNo -Caption "Docker registry does not exist." -Message "Do you want to initialize it automatically?" -DefaultChoice 0) {
                docker run -d -h $Hostname -p "${Port}:5000" --name $RegistryName "registry:2"

                Wait-Test -Test "-Not (Test-DockerRegistryRunning -Hostname $Hostname -Port $Port)" -WithProgressbar -Activity "Waiting for Docker registry to initialize"
            } Else {
                Read-Host "Please initialize the Docker registry manually. Press enter to continue..."
            }
        }
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER MachineName
    Parameter description

    .EXAMPLE
    An example
#>
Function Stop-DockerMachine {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    If (-Not (Test-DockerMachineCommand)) {
        Throw "Command `"docker-machine`" not found."
    }

    Write-Debug "Stopping machine $MachineName..."
    docker-machine stop $MachineName
}

<#
    .SYNOPSIS
    Stops a Docker stack.

    .DESCRIPTION
    Stops a Docker stack, waiting for all included containers to stop.

    .PARAMETER StackName
    The name of the stack to is to be stopped.

    .EXAMPLE
    Stop-DockerStack -StackName $NameDns
#>
Function Stop-DockerStack {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $StackName
    )

    docker stack rm ${StackName}

    Wait-Test -Test "Test-DockerStackRunning -StackNamespace $StackName" -WithProgressbar -Activity "Waiting for Docker stack to quit"
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example
#>
Function Test-DockerCommand {
    If (Get-Command -Name "docker" -ErrorAction "SilentlyContinue") {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example
#>
Function Test-DockerForWinInstalled {
    If (Test-AppInstalled -AppName "Docker") {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks if Docker is in swarm-mode.

    .DESCRIPTION
    Tries to create a swarm and returns false if successful, leaving the just created swarm.

    .EXAMPLE
    If (-Not (Test-DockerInSwarm)) {
        Write-Output "Initializing swarm..."
        docker swarm init --advertise-addr "eth0:2377"
    }
#>
Function Test-DockerInSwarm {
    $DockerSwarmInit = Invoke-ExpressionSafe -Command "docker swarm init --advertise-addr `"eth0:2377`"" -Graceful -WithError

    If ($DockerSwarmInit -CMatch "^Swarm initialized*") {
        docker swarm leave -f | Out-Null

        Return $False
    } Else {
        Return $True
    }
}

<#
    .SYNOPSIS
    Checks if Docker is installed.

    .DESCRIPTION
    Tries to access the command "docker" and returns true on success.

    .EXAMPLE
    While (-Not (Test-DockerInstalled)) {
        If (Read-PromptYesNo -Caption "Docker is not installed." -Message "Do you want to install it automatically?" -DefaultChoice 0) {
            Install-Docker
        } Else {
            Read-Host "Please install Docker manually. Press enter to continue..."
        }
    }
#>
Function Test-DockerInstalled {
    If ((Test-DockerForWinInstalled) -Or (Test-DockerToolboxInstalled)) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks if Docker is running.

    .DESCRIPTION
    Tries to find the Docker process and verifies the availability of the "docker ps" command.

    .EXAMPLE
    Wait-Test -Test "-Not (Test-DockerRunning)" -$WithProgressbar -Activity "Waiting for Docker to initialize"
#>
Function Test-DockerRunning {
    $DockerProcessesAll = Invoke-ExpressionSafe "docker ps -a" -Graceful -WithError

    If ((-Not $DockerProcessesAll) -Or ($DockerProcessesAll -CMatch "^docker : error*")) {
        Return $False
    } Else {
        Return $True
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example
#>
Function Test-DockerMachineEnvExists {
    If (Get-ChildItem -Path @("env:DOCKER_HOST", "env:DOCKER_CERT_PATH", "env:DOCKER_TLS_VERIFY", "env:DOCKER_MACHINE_NAME") -ErrorAction SilentlyContinue) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks if a Virtual Box machine exists.

    .DESCRIPTION
    Tries to show information about a virtual machine and return true if successful.

    .PARAMETER MachineName
    The name of the virtual machine that is to be checked.

    .EXAMPLE

    #>
Function Test-DockerMachineExists {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    $VBoxManage = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\VirtualBox").InstallDir + "VBoxManage.exe"

    & $VBoxManage showvminfo $MachineName | Out-Null

    If ($?) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example
#>
Function Test-DockerMachineCommand {
    If (Get-Command -Name "docker-machine" -ErrorAction "SilentlyContinue") {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks if Docker runs a registry container.

    .DESCRIPTION
    Tries to invoke a web request to the registry's catalog and returns true on success.

    .PARAMETER Hostname
    The hostname the registry is supposed to run on.

    .PARAMETER Port
    The port the registry is supposed to run on.

    .EXAMPLE
    While (-Not (Test-DockerRegistryRunning -Hostname $Hostname -Port $Port)) {
        # Start/Install registry
    }
#>
Function Test-DockerRegistryRunning {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-HostnameValid -Hostname $PSItem})]
        [String] $Hostname,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateScript({Test-PortValid -Port $PSItem})]
        [String] $Port
    )

    $DockerHost = Get-ChildItem -Path @("env:DOCKER_HOST") -ErrorAction SilentlyContinue

    If ($DockerHost -And ($DockerHost.Value -Match "^tcp:\/\/(.*):(.*)$")) {
        $Hostname = $Matches[1]
    }

    $WebRequest = Invoke-ExpressionSafe -Command "Invoke-WebRequest -Method GET -Uri `"http://${Hostname}:${Port}/v2/_catalog`" -UseBasicParsing" -Graceful

    If ($WebRequest) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks if a Docker stack runs.

    .DESCRIPTION
    Looks for running container with a matching "stack.namespace".

    .PARAMETER StackNamespace
    The stack's name that is to be checked.

    .EXAMPLE
    Wait-Test -Test "Test-DockerStackRunning -StackNamespace $StackName" -WithProgressbar -Activity "Waiting for Docker stack to quit"
#>
Function Test-DockerStackRunning {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $StackNamespace
    )

    $ServiceList = docker ps --filter "label=com.docker.stack.namespace=$StackNamespace" -q | Out-String

    If ($ServiceList) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .EXAMPLE
    An example
#>
Function Test-DockerToolboxInstalled {
    If (Test-AppInstalled -AppName "Docker Toolbox version \d+\.\d+\.\d+(-ce)*" -RegexCompare) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Create a Docker compose file.

    .DESCRIPTION
    Converts the data in a PSCustomObject to the YAML format and writes to file, removing unneccessary linebreaks.

    .PARAMETER ComposeFile
    An object containing the compose file's properties.

    .PARAMETER Path
    Path of the output file.

    .EXAMPLE
    Write-DockerComposeFile -ComposeFile $ComposeFile -Path $ProjectPath
#>
Function Write-DockerComposeFile {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject] $ComposeFile,

        [Parameter(Mandatory = $False)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $Path,

        [Parameter(Mandatory = $False)]
        [Switch] $Force
    )

    $Content = Convert-PSObjectToHashtable -InputObject $ComposeFile.Content
    $Command = "ConvertTo-Yaml -Data $Content -OutFile `"$Path\$($ComposeFile.Name)`""

    If ($Force) {
        Invoke-Expression -Command "$Command -Force"
    } Else {
        Invoke-Expression -Command $Command
    }
}

Export-ModuleMember -Function *
