---
external help file: ProjectLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Read-Settings.md
schema: 2.0.0
---

# Read-Settings

## SYNOPSIS
Reads settings fields in the JSON format and returns a PSCustomObject.

## SYNTAX

```
Read-Settings [-SourcePath] <String[]> [<CommonParameters>]
```

## DESCRIPTION
The "Read-Settings" cmdlet merges each source file's settings into a new object on top of the others.

## EXAMPLES

### EXAMPLE 1
```
Read-Settings -SourcePath @(".\package.json", ".\docker-management.json")
```

## PARAMETERS

### -SourcePath
An array of settings file paths.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Read-Settings.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Read-Settings.md)

