---
external help file: DockerLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-Docker.md
schema: 2.0.0
---

# Start-Docker

## SYNOPSIS
Starts Docker for Windows.

## SYNTAX

```
Start-Docker [[-MachineName] <String>] [[-DownloadMethod] <String>]
```

## DESCRIPTION
The "Start-Docker" cmdlet checks if Docker is installed, how it is installed and if it is running.
If not, it offers to install and start Docker automatically.

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

## INPUTS

## OUTPUTS

## NOTES
Source: https://gist.github.com/au-phiware/25213e72c80040f398ba

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-Docker.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Start-Docker.md)

