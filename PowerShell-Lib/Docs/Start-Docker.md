---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Start-Docker.md
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
If not, it offers to install and start Docker automatically.

## EXAMPLES

### EXAMPLE 1
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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Source: https://gist.github.com/au-phiware/25213e72c80040f398ba

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Start-Docker.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Start-Docker.md)

