---
external help file: DockerLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Write-DockerComposeFile

## SYNOPSIS
Create a Docker compose file.

## SYNTAX

```
Write-DockerComposeFile [-ComposeFile] <PSObject> [-Path <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
The "Write-DockerComposeFile" cmdlet converts the data in a PSCustomObject to the YAML format and writes that to a file, removing unneccessary linebreaks.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Write-DockerComposeFile -ComposeFile "docker-compose.yml" -Path ".\"
```

## PARAMETERS

### -ComposeFile
An object containing the compose file's properties.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Path of the output file.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
Whether to force-write the "OutFile" of "ConvertTo-Yaml".

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

