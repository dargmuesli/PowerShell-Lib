---
external help file: TextLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Clear-Linebreaks.md
schema: 2.0.0
---

# Clear-Linebreaks

## SYNOPSIS
Removes newlines from a string.

## SYNTAX

```
Clear-Linebreaks [-String] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Clear-Linebreaks" cmdlet replaces every line feed and carriage return characters with nothing.

## EXAMPLES

### BEISPIEL 1
```
Clear-Linebreaks -String "test`r`n123"
```

## PARAMETERS

### -String
The input string containing the unneeded newlines.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Clear-Linebreaks.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Clear-Linebreaks.md)

