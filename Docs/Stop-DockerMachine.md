---
external help file: DockerLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerMachine.md
schema: 2.0.0
---

# Stop-DockerMachine

## SYNOPSIS
Starts a Docker Machine.

## SYNTAX

```
Stop-DockerMachine [-MachineName] <String>
```

## DESCRIPTION
The "Stop-DockerMachine" cmdlet checks if the "docker-machine" command is available and if that's the case it stops the desired Docker Machine.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Stop-DockerMachine -MachineName "Docker"
```

## PARAMETERS

### -MachineName
The machine name that is to be used.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerMachine.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerMachine.md)

