Set-StrictMode -Version Latest

Function New-VBoxMachine {
    Param (
        [Parameter(Mandatory = $True)] [String] $VBoxName
    )

    Write-Debug "Creating Machine $VBoxName in VirtualBox..."
    docker-machine rm -f $VBoxName | Out-Null
    docker-machine create -d virtualbox --virtualbox-memory 2048 $VBoxName
}

Function Start-VBoxMachine {
    Param (
        [Parameter(Mandatory = $True)] [String] $VBoxName
    )

    Write-Debug "Starting machine $VBoxName..."
    docker-machine start $VBoxName
}

<#
    .SYNOPSIS
    Checks if a Virtual Box machine exists.
    
    .DESCRIPTION
    Tries to show information about a virtual machine and return true if successful.
    
    .PARAMETER VBoxName
    The name of the virtual machine that is to be checked.
    
    .EXAMPLE
    
    #>
Function Test-VBoxMachineExists {
    Param (
        [Parameter(Mandatory = $True)] [String] $VBoxName
    )

    $VBoxManage = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\VirtualBox").InstallDir + "VBoxManage.exe"

    & $VBoxManage showvminfo $VBoxName | Out-Null

    If ($?) {
        Return $True
    } Else {
        Return $False
    }
}