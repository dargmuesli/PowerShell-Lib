---
external help file: DockerLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Write-DockerComposeFile.md
schema: 2.0.0
---

# Write-DockerComposeFile

## SYNOPSIS
Create a Docker compose file.

## SYNTAX

```
Write-DockerComposeFile [-ComposeFile] <PSObject> [-Path <String>] [-Force]
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Write-DockerComposeFile.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Write-DockerComposeFile.md)

