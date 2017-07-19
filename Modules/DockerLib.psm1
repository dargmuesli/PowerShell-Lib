Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Installs Docker.

    .DESCRIPTION
    Downloads and starts the docker installer.

    .PARAMETER DownloadMethod
    Indicates which type of download function is to be used.

    .EXAMPLE
    Install-Docker

    .NOTES
    Download method "BITS" can display its progress, but can also be delayed by other downloads.
    Download method "WebClient" cannot display its progress.
    Download method "WebRequest" can display its progress, but is very slow.
#>
Function Install-Docker {
    Param (
        [Parameter(Mandatory = $False)] [String] $DownloadMethod = "BITS"
    )

    $Url = "https://download.docker.com/win/stable/InstallDocker.msi"
    # $Url = "https://download.docker.com/win/stable/DockerToolbox.exe"
    $Path = "$Env:Temp\InstallDocker.msi"

    If (-Not (Test-Path $Path)) {
        Switch ($DownloadMethod) {
            "BITS" {
                Import-Module BitsTransfer
                Start-BitsTransfer -Source $Url -Destination $Path
                break;
            }
            "WebClient" {
                $WebClient = New-Object Net.WebClient
                $WebClient.DownloadFile($Url, $Path)
                break;
            }
            "WebRequest" {
                Invoke-WebRequestWithProgress -Uri $Url -OutFile $Path -Overwrite
                break;
            }
        }
    }

    Start-Process msiexec.exe -Wait -ArgumentList "/I $Path"
    Remove-Item -Path $Path
}

Function Set-DockerMachineEnv {
    Param (
        [Parameter(Mandatory = $True)] [String] $VBoxName
    )

    Write-Debug -Message "Setting environment variables for machine $VBoxName ..."
    docker-machine env --shell=powershell $VBoxName | Invoke-Expression
}

<#
    .SYNOPSIS
    Starts Docker for Windows.

    .DESCRIPTION
    Checks if Docker is installed, how it is installed and if it is running. If not it offers to install and start Docker automatically.

    .EXAMPLE
    Start-Docker
#>
Function Start-Docker {
    Param (
        [Parameter(Mandatory = $False)] [String] $DownloadMethod = "BITS"
    )

    While (-Not (Test-DockerIsRunning)) {
        While (-Not (Test-DockerIsInstalled)) {
            While (-Not (Test-DockerIsInstalled)) {
                If (Read-PromptYesNo -Message "Docker is not installed." -Question "Do you want to install it automatically?" -Default 0) {
                    Install-Docker -DownloadMethod $DownloadMethod
                } Else {
                    Read-Host "Please install Docker manually. Press enter to continue ..."
                }
            }

            $PathDocker = (Get-Command docker).Path
            $PathDockerMachine = (Get-Command docker-machine).Path

            If ($PathDocker -And (Read-PromptYesNo -Message "Docker is not running." -Question "Do you want to start it automatically?" -Default 0)) {
                If ($PathDocker) {
                    & "$((Get-Item (Get-Command docker).Path).Directory.Parent.Parent.FullName)\Docker for Windows.exe"
                }

                Wait-Test -Test {-Not (Test-DockerIsRunning)} -WithProgressbar -Activity "Waiting for Docker to initialize"

                Break
            } Else {
                Read-Host "Please start Docker manually. Press enter to continue ..."
            }
        }
    }
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
        [Parameter(Mandatory = $True)] [String] $Name,
        [Parameter(Mandatory = $True)] [String] $Hostname,
        [Parameter(Mandatory = $True)] [String] $Port
    )

    While (-Not (Test-DockerRegistryIsRunning -Hostname $Hostname -Port $Port)) {
        $DockerInspectConfigHostname = docker inspect -f "{{.Config.Hostname}}" $Name | Out-String | ForEach-Object {
            If ($PSItem) {
                Clear-Linebreaks -String $PSItem
            }
        }

        If ($DockerInspectConfigHostname -And ($DockerInspectConfigHostname -Match "^[a-z0-9] {12}$")) {
            docker start $DockerInspectConfigHostname
        } Else {
            If (Read-PromptYesNo -Message "Docker registry does not exist." -Question "Do you want to initialize it automatically?" -Default 0) {
                docker run -d -p "${Port}:5000" --name $Name "registry:2"

                Wait-Test -Test {-Not (Test-DockerRegistryIsRunning  -Hostname $Hostname -Port $Port)} -WithProgressbar -Activity "Waiting for Docker registry to initialize"
            } Else {
                Read-Host "Please initialize the Docker registry manually. Press enter to continue ..."
            }
        }
    }
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
        [Parameter(Mandatory = $True)] [String] $StackName
    )

    docker stack rm ${StackName}
    Wait-Test -Test {Test-DockerStackIsRunning -StackNamespace $StackName} -WithProgressbar -Activity "Waiting for Docker stack to quit"
}

<#
    .SYNOPSIS
    Checks if Docker is in swarm-mode.

    .DESCRIPTION
    Tries to create a swarm and returns false if successful, leaving the just created swarm.

    .EXAMPLE
    If (-Not (Test-DockerInSwarm)) {
        Write-Output "Initializing swarm ..."
        docker swarm init
    }
#>
Function Test-DockerInSwarm {
    $DockerSwarmInit = Invoke-ExpressionSave -Command "docker swarm init" -Graceful -WithError

    If ($DockerSwarmInit -Like "Swarm initialized*") {
        docker swarm leave -f > $Null

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
    While (-Not (Test-DockerIsInstalled)) {
        If (Read-PromptYesNo -Message "Docker is not installed." -Question "Do you want to install it automatically?" -Default 0) {
            Install-Docker
        } Else {
            Read-Host "Please install Docker manually. Press enter to continue ..."
        }
    }
#>
Function Test-DockerIsInstalled {
    If (Get-Command -Name "docker" -ErrorAction SilentlyContinue) {
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
    Wait-Test -Test {-Not (Test-DockerIsRunning)} -$WithProgressbar -Activity "Waiting for Docker to initialize"
#>
Function Test-DockerIsRunning {
    $DockerActive = Get-Process "Docker for Windows" -ErrorAction SilentlyContinue | Out-String

    If (-Not $DockerActive) {
        Return $false
    } Else {
        $DockerProcessesAll = Invoke-ExpressionSave "docker ps -a" -Graceful -WithError

        If (($DockerProcessesAll -Like "docker : error*") -Or (-Not $DockerProcessesAll)) {
            Return $False
        } Else {
            Return $True
        }
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
    While (-Not (Test-DockerRegistryIsRunning -Hostname $Hostname -Port $Port)) {
        # Start/Install registry
    }
#>
Function Test-DockerRegistryIsRunning {
    Param (
        [Parameter(Mandatory = $True)] [String] $Hostname,
        [Parameter(Mandatory = $True)] [String] $Port
    )

    $WebRequest = Invoke-ExpressionSave -Command "Invoke-WebRequest -Method GET -Uri `"http://${Hostname}:${Port}/v2/_catalog`" -UseBasicParsing" -Graceful

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
    Wait-Test -Test {Test-DockerStackIsRunning -StackNamespace $StackName} -WithProgressbar -Activity "Waiting for Docker stack to quit"
#>
Function Test-DockerStackIsRunning {
    Param (
        [Parameter(Mandatory = $True)] [String] $StackNamespace
    )

    $ServiceList = docker ps --filter "label=com.docker.stack.namespace=$StackNamespace" -q | Out-String

    If ($ServiceList) {
        Return $True
    } Else {
        Return $False
    }
}

Function Test-DockerToolboxInstalled {
    If (Test-Path -Path "") {
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
        [Parameter(Mandatory = $True)] [PSCustomObject] $ComposeFile,
        [Parameter(Mandatory = $False)] [String] $Path
    )
    
    ConvertTo-Yaml -Data $ComposeFile.Content -OutFile "$Path\$($ComposeFile.Name)"
}

Export-ModuleMember -Function *
