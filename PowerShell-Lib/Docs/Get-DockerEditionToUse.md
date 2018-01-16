---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Get-DockerEditionToUse.md
schema: 2.0.0
---

# Get-DockerEditionToUse

## SYNOPSIS
Returns the Docker edition name that is to be used.

## SYNTAX

```
Get-DockerEditionToUse
```

## DESCRIPTION
The "Get-DockerEditionToUse" cmdlet test if Docker for Windows and Docker Toolbox are installed.
If only one is installed, that one is returned.
If both are installed, the user is asked which one is the user's preferred choice.

## EXAMPLES

### BEISPIEL 1
```
Get-DockerEditionToUse
```

## PARAMETERS

## INPUTS

## OUTPUTS

### Either "ForWin" or "Toolbox".

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Get-DockerEditionToUse.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Get-DockerEditionToUse.md)

