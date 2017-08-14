---
external help file: DockerLib-help.xml
Module Name: powershell-lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-DockerMachine.md
schema: 2.0.0
---

# Start-DockerMachine

## SYNOPSIS
Starts a Docker Machine.

## SYNTAX

```
Start-DockerMachine [-MachineName] <String>
```

## DESCRIPTION
The "Start-DockerMachine" cmdlet checks if the "docker-machine" command is available and if that's the case it starts the desired Docker Machine.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Start-DockerMachine -DockerMachine "Docker"
```

## PARAMETERS

### -MachineName
The machine name to start the VirtualBox for.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-DockerMachine.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-DockerMachine.md)

