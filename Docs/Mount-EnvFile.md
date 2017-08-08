---
external help file: PowerShellLib-help.xml
online version: Source: https://stackoverflow.com/a/31714410
schema: 2.0.0
---

# Mount-EnvFile

## SYNOPSIS
Sets environment variable from an .env file.

## SYNTAX

```
Mount-EnvFile [-EnvFilePath] <String> [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

