---
external help file: DockerLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Start-Docker

## SYNOPSIS
Starts Docker for Windows.

## SYNTAX

```
Start-Docker [[-MachineName] <String>] [[-DownloadMethod] <String>] [<CommonParameters>]
```

## DESCRIPTION
The "Start-Docker" cmdlet checks if Docker is installed, how it is installed and if it is running.
If not it offers to install and start Docker automatically.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Start-Docker -MachineName "Docker"
```

## PARAMETERS

### -MachineName
The machine name of the Docker Machine that is to be started.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: Docker
Accept pipeline input: False
Accept wildcard characters: False
```

### -DownloadMethod
The type of download function that is to be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: BITS
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Source: https://gist.github.com/au-phiware/25213e72c80040f398ba](Source: https://gist.github.com/au-phiware/25213e72c80040f398ba)

