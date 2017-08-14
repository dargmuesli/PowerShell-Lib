---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerStackRunning.md
schema: 2.0.0
---

# Test-DockerStackRunning

## SYNOPSIS
Checks whether a Docker stack is running.

## SYNTAX

```
Test-DockerStackRunning [-StackNamespace] <String>
```

## DESCRIPTION
The "Test-DockerStackRunning" cmdlet looks for a running container with a matching "stack.namespace" property.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-DockerStackRunning -StackNamespace "AppStack"
```

## PARAMETERS

### -StackNamespace
The stack's name that is to be checked.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerStackRunning.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerStackRunning.md)

