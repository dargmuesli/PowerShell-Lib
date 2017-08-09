---
external help file: DockerLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerMachineExists.md
schema: 2.0.0
---

# Test-DockerMachineExists

## SYNOPSIS
Checks whether a Docker Machine exists.

## SYNTAX

```
Test-DockerMachineExists [-MachineName] <String>
```

## DESCRIPTION
The "Test-DockerMachineExists" cmdlet tries to show information about the Docker Machine and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-DockerMachineExists -MachineName "Docker"
```

## PARAMETERS

### -MachineName
The name of the virtual machine that is to be checked.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerMachineExists.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerMachineExists.md)

