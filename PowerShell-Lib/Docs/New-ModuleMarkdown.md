---
external help file: ProjectLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/New-ModuleMarkdown.md
schema: 2.0.0
---

# New-ModuleMarkdown

## SYNOPSIS
Creates a markdown list for all functions in specified files.

## SYNTAX

```
New-ModuleMarkdown [-SourcePath] <String[]> [-DocPath] <String> [<CommonParameters>]
```

## DESCRIPTION
The "New-ModuleMarkdown" cmdlet reads all specified files and searches for function declarations within them.
It then returns a markdown list representation of all functions.

## EXAMPLES

### EXAMPLE 1
```
New-ModuleMarkdown -SourcePath @(".\PowerShell-Lib\Modules\*") -DocPath "PowerShell-Lib/Docs"
```

## PARAMETERS

### -SourcePath
The path to files that are to be examined.

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

### -DocPath
The path to where a functions markdown documentation can be found.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/New-ModuleMarkdown.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/New-ModuleMarkdown.md)

