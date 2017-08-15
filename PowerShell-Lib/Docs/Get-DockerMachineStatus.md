---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Get-DockerMachineStatus.md
schema: 2.0.0
---

# Get-DockerMachineStatus

## SYNOPSIS
Gets the status of a Docker Machine.

## SYNTAX

```
Get-DockerMachineStatus [-MachineName] <String>
```

## DESCRIPTION
The "Get-DockerMachineStatus" cmdlet checks if the "docker-machine" command is available and if that's the case it gets the Docker Machine's status.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Get-DockerMachineStatus -MachineName "Docker"
```

## PARAMETERS

### -MachineName
The machine's name to get the status from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Get-DockerMachineStatus.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Get-DockerMachineStatus.md)
