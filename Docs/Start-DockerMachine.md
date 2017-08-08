---
external help file: DockerLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Start-DockerMachine

## SYNOPSIS
Starts a Docker Machine.

## SYNTAX

```
Start-DockerMachine [-MachineName] <String> [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
