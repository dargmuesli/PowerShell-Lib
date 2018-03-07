<#
    .SYNOPSIS
    Checks whether a JDK is installed.

    .DESCRIPTION
    The "Test-JDKInstalled" cmdlet tests if an app with a name matching a regular expression for valid JDK names is installed and returns true if that's the case.

    .EXAMPLE
    Test-JDKInstalled

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-JDKInstalled.md

    .NOTES
    Matches:
        Java(TM) SE Development Kit 8
        Java(TM) SE Development Kit 8 (64-bit)
        Java(TM) SE Development Kit 8 Update 152
        Java(TM) SE Development Kit 8 Update 152 (64-bit)
        Java(TM) SE Development Kit 9
        Java(TM) SE Development Kit 9 (64-bit)
        Java(TM) SE Development Kit 9.0.1
        Java(TM) SE Development Kit 9.0.1 (64-bit)
#>
Function Test-JDKInstalled {
    If (Test-AppInstalled -AppName "^Java\(TM\) SE Development Kit \d+( \(64\-bit\)| Update \d+( \(64\-bit\))?|\.\d\.\d( \(64\-bit\))?)?$" -RegexCompare) {
        Return $True
    } Else {
        Return $False
    }
}

<#
    .SYNOPSIS
    Checks whether a JRE is installed.

    .DESCRIPTION
    The "Test-JREInstalled" cmdlet tests if an app with a name matching a regular expression for valid JRE names is installed and returns true if that's the case.

    .EXAMPLE
    Test-JREInstalled

    .LINK
    https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-JREInstalled.md

    .Notes
    Matches:
        Java 8
        Java 8 (64-bit)
        Java 8 Update 152
        Java 8 Update 152 (64-bit)
        Java 9
        Java 9 (64-bit)
        Java 9.0.1
        Java 9.0.1 (64-bit)
#>
Function Test-JREInstalled {
    
    If (Test-AppInstalled -AppName "^Java \d+( \(64\-bit\)| Update \d+( \(64\-bit\))?|\.\d\.\d( \(64\-bit\))?)?$" -RegexCompare) {
        Return $True
    } Else {
        Return $False
    }
}

Export-ModuleMember -Function *
