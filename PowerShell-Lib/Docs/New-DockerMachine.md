---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/New-DockerMachine.md
schema: 2.0.0
---

# New-DockerMachine

## SYNOPSIS
Creates a new Docker Machine.

## SYNTAX

```
New-DockerMachine [-MachineName] <String>
```

## DESCRIPTION
The "New-DockerMachine" cmdlet removes any existing Docker Machine with the desired name and creates a new VirtualBox with the same name.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
New-DockerMachine -MachineName "Docker"
```

## PARAMETERS

### -MachineName
The machine name to create a new VirtualBox for.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/New-DockerMachine.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/New-DockerMachine.md)

