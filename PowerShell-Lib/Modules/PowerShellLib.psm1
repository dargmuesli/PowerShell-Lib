Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Converts a PSCustomObject to a hashtable.

    .DESCRIPTION
    The "Convert-PSCustomObjectToHashtable" cmdlet iterates over a PSCustomObject's properties and adds name-value pairs to a hastable that it returns.

    .PARAMETER InputObject
    The PSCustomObject that is to be converted.

    .EXAMPLE
    Convert-PSCustomObjectToHashtable -InputObject $InputObject

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Convert-PSCustomObjectToHashtable.md
#>
Function Convert-PSCustomObjectToHashtable {
    Param (
        [Parameter(Mandatory = $True, Position = 0, ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject] $InputObject
    )

    $Hashtable = [Ordered] @{}

    $InputObject.PSObject.Properties |
        ForEach-Object {
        $InputProperty = $PSItem

        Switch ($PSItem.Value.GetType().Name) {
            "Hashtable" {
                $Hashtable[$InputProperty.Name] = Convert-PSCustomObjectToHashtable -InputObject ([PSCustomObject] $InputProperty.Value)
                Break
            }
            {@("Int32", "String") -Contains $PSItem} {
                $Hashtable[$InputProperty.Name] = $InputProperty.Value
                Break
            }
            "Object[]" {
                $Hashtable[$InputProperty.Name] = [Object[]] $InputProperty.Value
                Break
            }
        }
    }

    Return $Hashtable
}

<#
    .SYNOPSIS
    Downloads a file from a URL.

    .DESCRIPTION
    The "Get-FileFromWeb" cmdlet uses different methods to download a file from a URL and saves it to a desired location.

    .PARAMETER URL
    The URL where the requested resource is located.

    .PARAMETER LocalPath
    The path to where the requested file is to be saved to.

    .PARAMETER DownloadMethod
    The download function that is to be used.

    .EXAMPLE
    Get-FileFromWeb -URL "https://download.docker.com/win/stable/InstallDocker.msi" -LocalPath ".\"

    .NOTES
    Download method "BITS" can display its progress, but can also be delayed by other downloads.
    Download method "WebClient" cannot display its progress.
    Download method "WebRequest" can display its progress, but is very slow.

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Get-FileFromWeb.md
#>
Function Get-FileFromWeb {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-IRIValid -IRI $PSItem})]
        [String] $URL,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $LocalPath,

        [Parameter(Mandatory = $False)]
        [ValidateSet('BITS', 'WebClient', 'WebRequest')]
        [String] $DownloadMethod = "BITS"
    )

    Switch ($DownloadMethod) {
        "BITS" {
            Import-Module BitsTransfer
            Start-BitsTransfer -Source $Url -Destination $LocalPath
            Break
        }
        "WebClient" {
            $WebClient = New-Object Net.WebClient
            $WebClient.DownloadFile($Url, $LocalPath)
            Break
        }
        "WebRequest" {
            Invoke-WebRequestWithProgress -Uri $Url -OutFile $LocalPath -Overwrite
            Break
        }
    }
}

<#
    .SYNOPSIS
    Ensures that a path does not already exist.

    .DESCRIPTION
    The "Initialize-TaskPath" cmdlet checks whether a path exists and, depending on the "Overwrite" flag, deletes that path or throws an error.

    .PARAMETER TaskPath
    The path that is to be checked.

    .PARAMETER Overwrite
    Whether to remove the given path.

    .EXAMPLE
    Initialize-TaskPath -TaskPath "~\Project\Output.txt"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Initialize-TaskPath.md
#>
Function Initialize-TaskPath {
    Param (
        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $TaskPath,

        [Switch] $Overwrite
    )

    If (Test-Path -Path $TaskPath) {
        If ($Overwrite) {
            Remove-Item -Path $TaskPath
        } Else {
            Throw "The path already exists and the parameter `"Overwrite`" is not passed."
        }
    }
}

<#
    .SYNOPSIS
    Invokes an expression without causing crashes.

    .DESCRIPTION
    The "Invoke-ExpressionSafe" cmdlet Invokes the given command redirecting errors into a temporary file and other output into a variable.
    If the WithError parameter is given, the temporary file's output is appended to stdout.
    If the Graceful parameter is given and an error occurs, no exception is be thrown.

    .PARAMETER Command
    The expression to invoke safely.

    .PARAMETER WithHost
    Whether to return the host message in stdout.

    .PARAMETER WithError
    Whether to return the error message in stdout.

    .PARAMETER Graceful
    Prevents that an error is thrown.

    .EXAMPLE
    Invoke-ExpressionSafe -Command "docker swarm init --advertise-addr 'eth0:2377'" -WithError -Graceful

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Invoke-ExpressionSafe.md
#>
Function Invoke-ExpressionSafe {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $Command,

        [Switch] $WithHost,
        [Switch] $WithError,
        [Switch] $Graceful
    )

    $TmpFile = New-TemporaryFile
    $Stdout = $Null

    Try {
        $Stdout = Invoke-Expression -Command "$Command 2>$TmpFile"
        # | Tee-Object -Variable Stdout
        # -OutVariable Stdout
    } Catch {
        $PSItem > $TmpFile
    }

    $Stderr = Get-Content $TmpFile

    If (-Not $WithHost) {
        $Stdout = $Null
    }

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
    Download a file and displays a progress bar.

    .DESCRIPTION
    The "Invoke-WebRequestWithProgress" cmdlet creates a HttpWebRequest whose response stream is directed to a file.
    Every 10KB a progress bar showing the current download progress is displayed/updated.

    .PARAMETER Uri
    The URI of the file that is to be downloaded.

    .PARAMETER OutFile
    The path to where the file is to be saved to.

    .PARAMETER Overwrite
    Whether to overwrite an already existing downloaded file.

    .PARAMETER Timeout
    How long to wait for a connection success.

    .EXAMPLE
    Invoke-WebRequestWithProgress -Uri "https://download.docker.com/win/stable/InstallDocker.msi" -OutFile ".\"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Invoke-WebRequestWithProgress.md
#>
Function Invoke-WebRequestWithProgress {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-IRIValid -IRI $PSItem})]
        [Uri] $Uri,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $OutFile,

        [Parameter(Mandatory = $False)]
        [Switch] $Overwrite,

        [ValidateNotNullOrEmpty()]
        [Int] $Timeout = 15000
    )

    Initialize-TaskPath -TaskPath Initialize-TaskPath -Overwrite:$Overwrite

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
        $PercentComplete = [Convert]::ToInt32([Math]::Floor((($DownloadedBytes / 1024) / $TotalLength) * 100))
        Write-ProgressBar -PercentComplete $PercentComplete -Activity "Downloading $([Math]::Floor($DownloadedBytes / 1024))K of ${TotalLength}K"
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
    The "Merge-Objects" cmdlet adds all properties of the first object and the second object to a third one and returns the latter.

    .PARAMETER Object1
    The first source object.

    .PARAMETER Object2
    The second source object.

    .EXAMPLE
    Merge-Objects -Object1 @{test='123'} -Object2 @{123='test'}

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Merge-Objects.md
#>
Function Merge-Objects {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [Object] $Object1,

        [Parameter(Mandatory = $True, Position = 1)]
        [Object] $Object2
    )

    $ReturnObject = [PSCustomObject] @{}

    Foreach ($Property In $Object1.PSObject.Properties) {
        $ReturnObject | Add-Member -Type NoteProperty -Name $Property.Name -Value $Property.Value -Force
    }

    Foreach ($Property In $Object2.PSObject.Properties) {
        $ReturnObject | Add-Member -Type NoteProperty -Name $Property.Name -Value $Property.Value -Force
    }

    Return $ReturnObject
}

<#
    .SYNOPSIS
    Sets environment variable from an .env file.

    .DESCRIPTION
    The "Mount-EnvFile" cmdlet reads and parses each valid line from an .env file and sets the corresponding Windows environment variable.

    .PARAMETER EnvFilePath
    Path to the .env file that is to be mounted.

    .EXAMPLE
    Mount-EnvFile -EnvFilePath ".\.env"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Mount-EnvFile.md
#>
Function Mount-EnvFile {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateScript({Test-PathValid -Path $PSItem})]
        [String] $EnvFilePath
    )

    Get-Content $EnvFilePath |
        Select-String -Pattern "^[A-Z_]+=.+$" |
        ForEach-Object {
        $PSItem = $PSItem -Split "="
        Set-Item -Force -Path "env:$($PSItem[0])" -Value $PSItem[1]
    }
}

<#
    .SYNOPSIS
    Reads all PowerShell function names from a string.

    .DESCRIPTION
    The "Read-FunctionNames" cmdlet parses the input string and returns all findings of function names inside it.

    .PARAMETER InputString
    The string that is to be searched through.

    .EXAMPLE
    $InputString = @"
        Function X {
            $a = 1
        }
        Function Y {
            $b = 2
        }
    "@

    Read-FunctionNames -InputString $InputString

    .OUTPUTS
    Sorted by the functions' order of occurrence.

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Read-FunctionNames.md
#>
Function Read-FunctionNames {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $InputString
    )

    Return [System.Management.Automation.Language.Parser]::ParseInput(
        $InputString, [Ref] $Null, [Ref] $Null
    ).EndBlock.Statements.FindAll(
        [Func[Management.Automation.Language.Ast, bool]] {
            $Args[0] -Is [Management.Automation.Language.FunctionDefinitionAst]
        },
        $False
    ) |
        Select-Object -Expand Name
}

<#
    .SYNOPSIS
    Asks the user for his/her answer to a question.

    .DESCRIPTION
    The "Read-Prompt" cmdlet prompts the user for a choice regarding a question with the given parameters.

    .PARAMETER Caption
    The caption that is to be displayed.

    .PARAMETER Message
    The message that is to be displayed.

    .PARAMETER Choices
    A list of "Management.Automation.Host.ChoiceDescription"s the user can choose from.

    .PARAMETER DefaultChoice
    The choice that is selected by default.

    .EXAMPLE
    $Choices = [Management.Automation.Host.ChoiceDescription[]] (
        (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList 'Docker for Windows'),
        (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList 'Docker Toolbox')
    )
    Read-Prompt -Caption "Docker for Windows and Docker Toolbox are installed." -Message "Which one do you want to use?" -Choices $Choices -DefaultChoice 0

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Read-Prompt.md
#>
Function Read-Prompt {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $Caption,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String] $Message,

        [Parameter(Mandatory = $True, Position = 2)]
        [ValidateNotNullOrEmpty()]
        [Management.Automation.Host.ChoiceDescription[]] $Choices,

        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [Int] $DefaultChoice = 1
    )

    Return $Host.UI.PromptForChoice($Caption, $Message, $Choices, $DefaultChoice)
}

<#
    .SYNOPSIS
    Displays a yes/no prompt.

    .DESCRIPTION
    The "Read-PromptYesNo" cmdlet displays a yes/no prompt and waits for the user's choice.

    .PARAMETER Caption
    The caption that is to be displayed.

    .PARAMETER Message
    The message that is to be displayed.

    .PARAMETER DefaultChoice
    The choice that is selected by default.

    .EXAMPLE
    Read-PromptYesNo -Message "Docker is not installed." -Question "Do you want to install it automatically?" -DefaultChoice 0

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Read-PromptYesNo.md
#>
Function Read-PromptYesNo {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $Caption,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String] $Message,

        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [Int] $DefaultChoice = 1
    )

    $Choices = [Management.Automation.Host.ChoiceDescription[]] (
        (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'),
        (New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No')
    )

    $Decision = Read-Prompt -Caption $Caption -Message $Message -Choices $Choices -DefaultChoice $DefaultChoice

    If ($Decision -Eq 0) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks whether an environment variable exists.

    .DESCRIPTION
    The "Test-EnvVarExists" cmdlet checks the existence of an environment variable and returns true on success.

    .PARAMETER EnvVarName
    The environment variable's name that is to be checked.

    .EXAMPLE
    Test-EnvVarExists -EnvVarName "OS"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-EnvVarExists.md
#>
Function Test-EnvVarExists {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $EnvVarName
    )

    If (Get-ChildItem -Path "env:$EnvVarName" -ErrorAction SilentlyContinue) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks whether a PowerShell module is installed.

    .DESCRIPTION
    The "Test-ModuleInstalled" cmdlet tries to get the desired module and return true on success.

    .PARAMETER ModuleName
    The module's name that is to be checked.

    .EXAMPLE
    Test-ModuleInstalled -ModuleName "PowerShell-Lib"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-ModuleInstalled.md
#>
Function Test-ModuleInstalled {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $ModuleName
    )

    If (Get-Module -ListAvailable -Name $ModuleName) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks whether an object's property exists.

    .DESCRIPTION
    The "Test-PropertyExists" cmdlet checks if an object contains a property name and returns true on success.

    .PARAMETER Object
    The object that is to be checked for properties.

    .PARAMETER PropertyName
    The object's property name that is to be checked.

    .EXAMPLE
    Test-PropertyExists -Object {test='123'} -PropertyName "test"

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-PropertyExists.md
#>
Function Test-PropertyExists {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [Object] $Object,

        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String] $PropertyName
    )

    $PropertyNameParts = @()

    $IndexFirstDot = $PropertyName.IndexOf(".")

    If ($IndexFirstDot -Ne -1) {
        $PropertyNameParts += $PropertyName.Substring(0, $IndexFirstDot)
        $PropertyNameParts += $PropertyName.Substring($IndexFirstDot + 1, $PropertyName.Length - ($IndexFirstDot + 1))

        If ($Object.PSObject.Properties.Name -Contains $PropertyNameParts[0]) {
            Return Test-PropertyExists -Object ($Object | Select-Object -ExpandProperty $PropertyNameParts[0]) -PropertyName $PropertyNameParts[1]
        } Else {
            Return $False
        }
    } Else {
        If (($Object.PSObject.Properties.Name -Contains $PropertyName) -Or ($Object.Keys -Contains $PropertyName)) {
            Return $True
        } Else {
            Return $False
        }
    }
}

<#
    .SYNOPSIS
    Displays an indeterminate progress bar while a test is successful.

    .DESCRIPTION
    The "Wait-Test" cmdlet increases the progress bar's value in steps from 0 to 100 infinitely to provide visual feedback about a running task to the user.

    .PARAMETER Test
    The task check which needs to pass.

    .PARAMETER Activity
    A description of the running task.

    .PARAMETER Milliseconds
    The time to wait between test checks.

    .PARAMETER WithProgressBar
    Whether to display a progress bar.

    .EXAMPLE
    Wait-Test -Test "-Not (Test-DockerRunning)" -Activity "Waiting for Docker to initialize" -WithProgressBar

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Wait-Test.md
#>
Function Wait-Test {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String] $Test,

        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [String] $Activity = "Processing",

        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [Int] $Milliseconds = 1000,

        [Switch] $WithProgressBar
    )

    $Index = 0

    While (Invoke-Expression -Command $Test) {
        $Index++

        If ($Index -Eq 100) {
            $Index = 0
        }

        If ($WithProgressBar) {
            Write-ProgressBar -Activity "$Activity ..." -PercentComplete $Index
        }

        Start-Sleep -Milliseconds $Milliseconds
    }

    If ($WithProgressBar) {
        Write-Progress -Completed $True
    }
}

<#
    .SYNOPSIS
    Displays a progress bar.

    .DESCRIPTION
    The "Write-ProgressBar" cmdlet displays a progress bar with a given progress percentage and a description of the currently running activity.

    .PARAMETER PercentComplete
    The progress of the progress bar.

    .PARAMETER Activity
    A description of the activity that is running.

    .EXAMPLE
    Write-ProgressBar -Activity "Checking ..." -PercentComplete $Index

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Write-ProgressBar.md
#>
Function Write-ProgressBar {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [Int] $PercentComplete,

        [Parameter(Mandatory = $False)]
        [ValidateNotNullOrEmpty()]
        [String] $Activity = "Processing"
    )

    Write-Progress -Activity "$Activity" -PercentComplete $PercentComplete
}

Export-ModuleMember -Function *
