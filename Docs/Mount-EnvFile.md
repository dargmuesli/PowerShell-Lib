---
external help file: PowerShellLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Mount-EnvFile.md
schema: 2.0.0
---

# Mount-EnvFile

## SYNOPSIS
Sets environment variable from an .env file.

## SYNTAX

```
Mount-EnvFile [-EnvFilePath] <String>
```

## DESCRIPTION
The "Mount-EnvFile" cmdlet reads and parses each valid line from an .env file and sets the corresponding Windows environment variable.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Mount-EnvFile -EnvFilePath ".\.env"
```

## PARAMETERS

### -EnvFilePath
Path to the .env file that is to be mounted.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Mount-EnvFile.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Mount-EnvFile.md)

