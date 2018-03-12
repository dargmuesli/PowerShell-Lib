---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/New-DockerMachine.md
schema: 2.0.0
---

# New-DockerMachine

## SYNOPSIS
Creates a new Docker Machine.

## SYNTAX

```
New-DockerMachine [-MachineName] <String> [<CommonParameters>]
```

## DESCRIPTION
The "New-DockerMachine" cmdlet removes any existing Docker Machine with the desired name and creates a new VirtualBox with the same name.

## EXAMPLES

### EXAMPLE 1
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/New-DockerMachine.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/New-DockerMachine.md)

