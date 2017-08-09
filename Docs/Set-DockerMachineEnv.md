---
external help file: DockerLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Set-DockerMachineEnv.md
schema: 2.0.0
---

# Set-DockerMachineEnv

## SYNOPSIS
Creates all Docker Machine environment variables.

## SYNTAX

```
Set-DockerMachineEnv [-MachineName] <String>
```

## DESCRIPTION
The "Set-DockerMachineEnv" cmdlet checks if the "docker-machine" command is available and if that's the case it sets the Docker Machine environment variables.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Set-DockerMachineEnv -MachineName "Docker"
```

## PARAMETERS

### -MachineName
The machine name to set Docker environment variables for.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Set-DockerMachineEnv.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Set-DockerMachineEnv.md)

