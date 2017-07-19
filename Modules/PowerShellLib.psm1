Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Invokes an expression without causing crashes.

    .DESCRIPTION
    Invokes the given command redirecting errors into a temporary file and other output into a variable.
    If the WithError parameter is given, the temporary file's output is appended to stdout.
    If the Graceful parameter is given and an error occurs, no exception is be thrown.

    .PARAMETER Command
    The expression to invoke savely.

    .PARAMETER WithError
    Wether to return the error message in stdout.

    .PARAMETER Graceful
    Prevents that an error is thrown.

    .EXAMPLE
    $DockerSwarmInit = Invoke-ExpressionSave -Command "docker swarm init" -WithError -Graceful
#>
Function Invoke-ExpressionSave {
    Param (
        [Parameter(Mandatory = $True)] [String] $Command,
        [Parameter(Mandatory = $False)] [Switch] $WithError,
        [Parameter(Mandatory = $False)] [Switch] $Graceful
    )

    $TmpFile = New-TemporaryFile
    $Stdout = ""

    Try {
        Invoke-Expression -Command "$Command 2>$TmpFile" -OutVariable Stdout | Tee-Object -Variable Stdout
    } Catch {
        $PSItem > $TmpFile
    }

    $Stderr = Get-Content $TmpFile

    If ($WithError) {
        $Stdout = "${Stdout}${Stderr}"
    }

    $Stdout
    Remove-Item $TmpFile

    If ($Stderr -And (-Not $Graceful)) {
        Throw $Stderr
    }
}

<#
    .SYNOPSIS
    Download a file and displays a progressbar.

    .DESCRIPTION
    Verifies that an existing file is managed as requested.
    Then creates a HttpWebRequest whose response stream is directed to a file.
    Every 10KB a progressbar showing the current download progress is displayed/updated.

    .PARAMETER Uri
    The Uri of the file that is to be downloaded

    .PARAMETER Outfile
    The path to where the file is to be saved.

    .EXAMPLE
    Invoke-WebRequestWithProgress -Uri "https://download.docker.com/win/stable/InstallDocker.msi" -OutFile $Path -Overwrite
#>
Function Invoke-WebRequestWithProgress {
    Param (
        [Parameter(Mandatory = $True)] [Uri] $Uri,
        [Parameter(Mandatory = $True)] [String] $OutFile,
        [Parameter(Mandatory = $False)] [Switch] $Overwrite,
        [Parameter(Mandatory = $False)] [Int] $Timeout = 15000
    )

    If (Test-Path $OutFile) {
        If ($Overwrite) {
            Remove-Item -Path $OutFile
        } Else {
            Throw "The file that is to be downloaded already exists at the indicated location and the parameter `"Overwrite`" is not passed."
        }
    }

    $Request = [Net.HttpWebRequest]::Create($Uri)
    $Request.Set_Timeout($Timeout)
    $Response = $Request.GetResponse()
    $TotalLength = [Math]::Floor($Response.Get_ContentLength() / 1024)
    $ResponseStream = $Response.GetResponseStream()
    $TargetStream = New-Object -TypeName IO.FileStream -ArgumentList $OutFile, Create
    $Buffer = New-Object Byte[] 10KB
    $Count = $ResponseStream.Read($Buffer, 0, $Buffer.Length)
    $DownloadedBytes = $Count

    While ($Count -Gt 0) {
        $test = [Convert]::ToInt32([Math]::Floor((($DownloadedBytes / 1024) / $TotalLength) * 100))
        Write-Progressbar -PercentComplete $test `
            -Activity "Downloading $([Math]::Floor($DownloadedBytes / 1024))K of ${TotalLength}K"
        $TargetStream.Write($Buffer, 0, $Count)
        $Count = $ResponseStream.Read($Buffer, 0, $Buffer.Length)
        $DownloadedBytes = $DownloadedBytes + $Count
    }

    Write-Progress -Completed $True

    $TargetStream.Flush()
    $TargetStream.Close()
    $TargetStream.Dispose()
    $ResponseStream.Dispose()
}

<#
    .SYNOPSIS
    Merges two objects into one.

    .DESCRIPTION
    Adds all properties of the first and then the second object to a third one and returns the latter.

    .PARAMETER Object1
    The first source object.

    .PARAMETER Object2
    The second source object.

    .EXAMPLE
    $Settings = Merge-Objects -Object1 $Settings -Object2 (Get-Content -Path $SourcesPath | ConvertFrom-Json)
#>
Function Merge-Objects { 
    Param (
        [Parameter(Mandatory = $True)] $Object1,
        [Parameter(Mandatory = $True)] $Object2
    )
    
    $ReturnObject = [PSCustomObject] @{}

    Foreach ($Property In $Object1.PSObject.Properties) {
        $ReturnObject | Add-Member -NotePropertyName $Property.Name -NotePropertyValue $Property.Value -Force
    }

    Foreach ($Property In $Object2.PSObject.Properties) {
        $ReturnObject | Add-Member -NotePropertyName $Property.Name -NotePropertyValue $Property.Value -Force
    }
    
    return $ReturnObject
}

<#
    .SYNOPSIS
    Sets environment variable from an .env file.

    .DESCRIPTION
    Reads and parses each valid line from an .env file and sets the corresponding Windows environment variable.

    .PARAMETER EnvFilePath
    Path to the .env file that is to be mounted

    .EXAMPLE
    Mount-EnvFile -EnvFilePath "$ProjectPath\.env"
#>
Function Mount-EnvFile {
    Param (
        [Parameter(Mandatory = $True)] [String] $EnvFilePath
    )

    Get-Content $EnvFilePath | Select-String -Pattern "^[A-Z_]+=.+$" | ForEach-Object {
        $PSItem = $PSItem -Split "="
        Set-Item -Force -Path "env:$($PSItem[0])" -Value $PSItem[1]
    }
}

<#
    .SYNOPSIS
    Displays a yes/no prompt.

    .DESCRIPTION
    Displays a yes/no prompt and waits for the user's choice.

    .PARAMETER Message
    A description of the state that requires a user's choice.

    .PARAMETER Question
    A possible solution to the problem.

    .PARAMETER Default
    The preselected answer.

    .EXAMPLE
    If (Read-PromptYesNo -Message "Docker is not installed." -Question "Do you want to install it automatically?" -Default 0) {
        Install-Docker
    } Else {
        Read-Host "Please install Docker manually. Press enter to continue ..."
    }
#>
Function Read-PromptYesNo {
    Param (
        [Parameter(Mandatory = $True)] [String] $Message,
        [Parameter(Mandatory = $False)] [String] $Question = 'Proceed?',
        [Parameter(Mandatory = $False)] [String] $Default = 1
    )

    $Choices = [Management.Automation.Host.ChoiceDescription[]] (
        (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'),
        (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No')
    )
    $Decision = $Host.UI.PromptForChoice($Message, $Question, $Choices, $Default)
    
    If ($Decision -Eq 0) {
        Return $True
    } Else {
        Return $False
    }
}

Function Test-EnvVarExists {
    Param (
        [Parameter(Mandatory = $True)] [String] $EnvVarName
    )

    If (Get-ChildItem -Path "env:$EnvVarName" -ErrorAction SilentlyContinue) {
        Return $True
    } Else {
        Return $False
    }
}

Function Test-PropertyExists {
    Param (
        [Parameter(Mandatory = $True)] $Object,
        [Parameter(Mandatory = $True)] [String] $PropertyName
    )

    Return $Object.PSObject.Properties.Name -Contains $PropertyName
}

<#
    .SYNOPSIS
    Displays an indeterminate progressbar while a test is successful.

    .DESCRIPTION
    Increases the progressbar's value in steps from 0 to 100 infinitly to provide visual feedback about a running task to the user.

    .PARAMETER Test
    The task check which needs to pass.

    .PARAMETER Milliseconds
    The time to wait between test checks.

    .PARAMETER WithProgressbar
    Wether to display a progressbar.

    .PARAMETER Activity
    A description of the running task.

    .EXAMPLE
    Wait-Test -Test {-Not (Test-DockerIsRunning)} -$WithProgressbar -Activity "Waiting for Docker to initialize"
#>
Function Wait-Test {
    Param (
        [Parameter(Mandatory = $True)] [String] $Test,
        [Parameter(Mandatory = $False)] [Int] $Milliseconds = 1000,
        [Parameter(Mandatory = $False)] [Switch] $WithProgressbar,
        [Parameter(Mandatory = $False)] [String] $Activity = "Processing"
    )

    $I = 0

    While (Invoke-Expression -Command $Test) {
        $I++

        If ($I -Eq 100) {
            $I = 0
        }

        If ($WithProgressbar) {
            Write-Progressbar -Activity "$Activity ..." -PercentComplete $I
        }

        Start-Sleep -Milliseconds $Milliseconds
    }

    If ($WithProgressbar) {
        Write-Progress -Completed $True
    }
}

Function Write-Progressbar {
    Param (
        [Parameter(Mandatory = $True)] [Int] $PercentComplete,
        [Parameter(Mandatory = $False)] [String] $Activity = "Processing"
    )

    Write-Progress -Activity "$Activity" -PercentComplete $PercentComplete
}

Export-ModuleMember -Function *