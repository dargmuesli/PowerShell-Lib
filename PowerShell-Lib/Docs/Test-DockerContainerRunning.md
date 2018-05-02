---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-DockerContainerRunning.md
schema: 2.0.0
---

# Test-DockerContainerRunning

## SYNOPSIS
Checks whether a Docker container is running.

## SYNTAX

```
Test-DockerContainerRunning [-Name] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Test-DockerContainerRunning" cmdlet queries the running containers, filtering them by the given name, and returns true if there is a query result.

## EXAMPLES

### EXAMPLE 1
```
Test-DockerContainerRunning -Name "registry"
```

## PARAMETERS

### -Name
The name of the container that is to be checked.

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

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-DockerContainerRunning.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-DockerContainerRunning.md)

