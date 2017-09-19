Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Removes all Docker Machine environment variables.

    .DESCRIPTION
    The "Clear-DockerMachineEnv" cmdlet unsets the Docker Machine environment variables.

    .EXAMPLE
    Clear-DockerMachineEnv

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Clear-DockerMachineEnv.md
#>
Function Clear-DockerMachineEnv {
    Write-Debug -Message "Clearing environment variables..."
    Invoke-DockerMachine env --shell=powershell --unset | Invoke-Expression
}

<#
    .SYNOPSIS
    Returns the Docker edition name that is to be used.

    .DESCRIPTION
    The "Get-DockerEditionToUse" cmdlet test if Docker for Windows and Docker Toolbox are installed.
    If only one is installed, that one is returned.
    If both are installed, the user is asked which one is the user's preferred choice.

    .EXAMPLE
    Get-DockerEditionToUse

    .OUTPUTS
    Either "ForWin" or "Toolbox".

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Get-DockerEditionToUse.md
#>
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
    Gets the status of a Docker Machine.

    .DESCRIPTION
    The "Get-DockerMachineStatus" cmdlet gets the Docker Machine's status.

    .PARAMETER MachineName
    The machine's name to get the status from.

    .EXAMPLE
    Get-DockerMachineStatus -MachineName "Docker"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Get-DockerMachineStatus.md
#>
Function Get-DockerMachineStatus {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    Invoke-DockerMachine status $MachineName
}

<#
    .SYNOPSIS
    Installs Docker.

    .DESCRIPTION
    The "Install-Docker" cmdlet downloads and executes the Docker installer.

    .PARAMETER Edition
    The edition of Docker that is to be used.

    .PARAMETER DownloadMethod
    The type of download function that is to be used.

    .EXAMPLE
    Install-Docker

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Install-Docker.md
#>
Function Install-Docker {
    Param (
        [Parameter(Mandatory = $False)]
        [ValidateSet('ForWin', 'Toolbox')]
        [String] $Edition = "ForWin",

        [Parameter(Mandatory = $False)]
        [ValidateSet('BITS', 'WebClient', 'WebRequest')]
        [String] $DownloadMethod = "BITS",

        [Switch] $Ask
    )

    $Answer = $Null

    If ($Ask) {
        $Answer = Read-PromptYesNo -Caption "Docker is not installed." -Message "Do you want to install it automatically?" -DefaultChoice 0
    } Else {
        Read-Host "Please install Docker manually. Press enter to continue..."
    }

    If ((-Not $Ask) -Or ($Ask -And $Answer)) {
        Switch ($Edition) {
            "ForWin" {
                $RemoteFilename = "InstallDocker.msi"
                $Path = "$Env:Temp\$RemoteFilename"

                Get-FileFromWeb -URL "https://download.docker.com/win/stable/$RemoteFilename" -LocalPath $Path -DownloadMethod $DownloadMethod
                Install-App -InstallerPath $Path
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
}

<#
    .SYNOPSIS
    Invokes docker-machine commands.

    .DESCRIPTION
    The "Invoke-DockerMachine" cmdlet verifies the existence of the "docker-machine" command and executes it with the given parameters.

    .EXAMPLE
    Invoke-DockerMachine status MachineName

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Invoke-DockerMachine.md
#>
Function Invoke-DockerMachine {
    If (-Not (Test-DockerMachineCommand)) {
        Throw "Command `"docker-machine`" not found."
    }

    docker-machine $Args
}

<#
    .SYNOPSIS
    Creates a new Docker Machine.

    .DESCRIPTION
    The "New-DockerMachine" cmdlet removes any existing Docker Machine with the desired name and creates a new VirtualBox with the same name.

    .PARAMETER MachineName
    The machine name to create a new VirtualBox for.

    .EXAMPLE
    New-DockerMachine -MachineName "Docker"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/New-DockerMachine.md
#>
Function New-DockerMachine {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    Write-Debug -Message "Creating machine `"$MachineName`" in VirtualBox..."
    Invoke-DockerMachine rm -f $MachineName
    Invoke-DockerMachine create -d virtualbox --virtualbox-memory 2048 $MachineName
}

<#
    .SYNOPSIS
    Creates all Docker Machine environment variables.

    .DESCRIPTION
    The "Set-DockerMachineEnv" cmdlet sets the Docker Machine environment variables.

    .PARAMETER MachineName
    The machine name to set Docker environment variables for.

    .EXAMPLE
    Set-DockerMachineEnv -MachineName "Docker"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Set-DockerMachineEnv.md
#>
Function Set-DockerMachineEnv {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    Write-Debug -Message "Setting environment variables for machine `"$MachineName`"..."
    Invoke-DockerMachine env --shell=powershell $MachineName
}

<#
    .SYNOPSIS
    Starts Docker for Windows.

    .DESCRIPTION
    The "Start-Docker" cmdlet checks if Docker is installed, how it is installed and if it is running.
    If not, it offers to install and start Docker automatically.

    .PARAMETER MachineName
    The machine name of the Docker Machine that is to be started.

    .PARAMETER DownloadMethod
    The type of download function that is to be used.

    .EXAMPLE
    Start-Docker -MachineName "Docker"

    .NOTES
    Source: https://gist.github.com/au-phiware/25213e72c80040f398ba

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-Docker.md
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

    If (-Not (Test-DockerInstalled)) {
        Install-Docker -DownloadMethod $DownloadMethod -Ask
    }

    If (-Not (Test-DockerRunning)) {
        Switch (Get-DockerEditionToUse) {
            "ForWin" {
                $DockerPath = (Get-Command docker).Path

                If ($DockerPath -And (Read-PromptYesNo -Caption "Docker is not running." -Message "Do you want to start it automatically?" -DefaultChoice 0)) {
                    If ($DockerPath) {
                        & "$((Get-Item $DockerPath).Directory.Parent.Parent.FullName)\Docker for Windows.exe"
                    }

                    Wait-Test -Test "-Not (Test-DockerRunning)" -Activity "Waiting for Docker to initialize" -WithProgressBar
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

                Wait-Test -Test "-Not (Test-DockerRunning)" -Activity "Waiting for Docker to initialize" -WithProgressBar
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
    Starts a Docker Machine.

    .DESCRIPTION
    The "Start-DockerMachine" cmdlet starts the desired Docker Machine.

    .PARAMETER MachineName
    The machine name to start the VirtualBox for.

    .EXAMPLE
    Start-DockerMachine -DockerMachine "Docker"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-DockerMachine.md
#>
Function Start-DockerMachine {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    Write-Debug -Message "Starting machine $MachineName..."
    Invoke-DockerMachine start $MachineName
}

<#
    .SYNOPSIS
    Starts a registry container in Docker.

    .DESCRIPTION
    Tries to start the Docker registry image and offers to install it in case it is not.

    .PARAMETER RegistryName
    The registry container's name that is to be used.

    .PARAMETER Hostname
    The hostname on which the registry should be available.

    .PARAMETER Port
    The port on which the registry should be available.

    .EXAMPLE
    Start-DockerRegistry -Name "registry" -Host "localhost" -Port "8080"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-DockerRegistry.md
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

                Wait-Test -Test "-Not (Test-DockerRegistryRunning -Hostname $Hostname -Port $Port)" -WithProgressBar -Activity "Waiting for Docker registry to initialize"
            } Else {
                Read-Host "Please initialize the Docker registry manually. Press enter to continue..."
            }
        }
    }
}

<#
    .SYNOPSIS
    Starts a Docker Machine.

    .DESCRIPTION
    The "Stop-DockerMachine" cmdlet stops the desired Docker Machine.

    .PARAMETER MachineName
    The machine name that is to be used.

    .EXAMPLE
    Stop-DockerMachine -MachineName "Docker"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerMachine.md
#>
Function Stop-DockerMachine {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    Write-Debug -Message "Stopping machine $MachineName..."
    Invoke-DockerMachine stop $MachineName
}

<#
    .SYNOPSIS
    Stops a Docker stack.

    .DESCRIPTION
    The "Stop-DockerStack" cmdlet stops a Docker stack and waits for all included containers to stop.

    .PARAMETER StackName
    The name of the stack to is to be stopped.

    .EXAMPLE
    Stop-DockerStack -StackName "appstack"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerStack.md
#>
Function Stop-DockerStack {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $StackName
    )

    Write-Debug -Message "Removing Docker stack $StackName..."
    docker stack rm $StackName

    Wait-Test -Test "Test-DockerStackRunning -StackNamespace $StackName" -WithProgressBar -Activity "Waiting for Docker stack to quit"
}

<#
    .SYNOPSIS
    Checks the availability of the "docker" command.

    .DESCRIPTION
    The "Test-DockerCommand" cmdlet tries to get the "docker" command and returns true on success.

    .EXAMPLE
    Test-DockerCommand

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerCommand.md
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
    Checks whether Docker for Windows is installed.

    .DESCRIPTION
    The "Test-DockerForWinInstalled" cmdlet tests if an app with the name "Docker" is installed and returns true if that's the case.

    .EXAMPLE
    Test-DockerForWinInstalled

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerForWinInstalled.md
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
    Checks whether Docker is installed.

    .DESCRIPTION
    The "Test-DockerInstalled" cmdlet tries to access the command "docker" and "docker-machine" and returns true if at least one is successful.

    .EXAMPLE
    Test-DockerInstalled

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerInstalled.md
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
    Checks whether Docker is in swarm-mode.

    .DESCRIPTION
    The "Test-DockerInSwarm" cmdlet tries to create a swarm and returns false if successful, leaving the just created swarm.

    .EXAMPLE
    Test-DockerInSwarm

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerInSwarm.md
#>
Function Test-DockerInSwarm {
    $DockerSwarmInit = Invoke-ExpressionSafe -Command "docker swarm init --advertise-addr `"eth0:2377`"" -Graceful -WithError

    If ($DockerSwarmInit -CMatch "^Swarm initialized*") {
        Invoke-ExpressionSafe -Command "docker swarm leave -f" -Graceful | Out-Null

        Return $False
    } Else {
        Return $True
    }
}

<#
    .SYNOPSIS
    Checks the availability of the "docker-machine" command.

    .DESCRIPTION
    The "Test-DockerMachineCommand" cmdlet tries to get the "docker-machine" command and returns true on success.

    .EXAMPLE
    Test-DockerMachineCommand

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerMachineCommand.md
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
    Checks whether Docker Machine environment variables exist.

    .DESCRIPTION
    The "Test-DockerMachineEnvExists" cmdlet checks if "DOCKER_HOST", "DOCKER_CERT_PATH", "DOCKER_TLS_VERIFY" and "DOCKER_MACHINE_NAME" environment variables exist and retun true on success.

    .EXAMPLE
    Test-DockerMachineEnvExists

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerMachineEnvExists.md
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
    Checks whether a Docker Machine exists.

    .DESCRIPTION
    The "Test-DockerMachineExists" cmdlet tries to show information about the Docker Machine and returns true on success.

    .PARAMETER MachineName
    The name of the virtual machine that is to be checked.

    .EXAMPLE
    Test-DockerMachineExists -MachineName "Docker"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerMachineExists.md
#>
Function Test-DockerMachineExists {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $MachineName
    )

    $VBoxManage = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\VirtualBox").InstallDir + "VBoxManage.exe"

    & $VBoxManage showvminfo $MachineName | Out-Null

    If ($LastExitCode -Eq 0) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks whether Docker runs a registry container.

    .DESCRIPTION
    The "Test-DockerRegistryRunning" cmdlet tries to invoke a web request to the registry's catalog and returns true on success.

    .PARAMETER Hostname
    The hostname the registry is supposed to run on.

    .PARAMETER Port
    The port the registry is supposed to run on.

    .EXAMPLE
    Test-DockerRegistryRunning -Hostname "localhost" -Port "8080"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerRegistryRunning.md
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
    Checks whether Docker is running.

    .DESCRIPTION
    The "Test-DockerRunning" cmdlet tries to verify the availability of the "docker ps" command and returns true on success.

    .EXAMPLE
    Test-DockerRunning

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerRunning.md
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
    Checks whether a Docker stack is running.

    .DESCRIPTION
    The "Test-DockerStackRunning" cmdlet looks for a running container with a matching "stack.namespace" property.

    .PARAMETER StackNamespace
    The stack's name that is to be checked.

    .EXAMPLE
    Test-DockerStackRunning -StackNamespace "AppStack"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerStackRunning.md
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
    Checks whether Docker Toolbox is installed.

    .DESCRIPTION
    The "Test-DockerToolboxInstalled" cmdlet checks if an app is installed that matches the Docker Toolbox app name pattern and returns true on success.

    .EXAMPLE
    Test-DockerToolboxInstalled

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerToolboxInstalled.md
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
    The "Write-DockerComposeFile" cmdlet converts the data in a PSCustomObject to the YAML format and writes that to a file, removing unneccessary linebreaks.

    .PARAMETER ComposeFile
    An object containing the compose file's properties.

    .PARAMETER Path
    Path of the output file.

    .PARAMETER Force
    Whether to force-write the "OutFile" of "ConvertTo-Yaml".

    .EXAMPLE
    Write-DockerComposeFile -ComposeFile "docker-compose.yml" -Path ".\"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Write-DockerComposeFile.md
#>
Function Write-DockerComposeFile {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject] $ComposeFile,

        [Parameter(Mandatory = $False)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $Path,

        [Switch] $Force
    )

    $Content = Convert-PSCustomObjectToHashtable -InputObject $ComposeFile.Content
    $Command = "ConvertTo-Yaml -Data $Content -OutFile `"$Path\$($ComposeFile.Name)`""

    Invoke-Expression -Command "$Command -Force:$Force"
}

Export-ModuleMember -Function *
