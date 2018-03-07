---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-PatternValid.md
schema: 2.0.0
---

# Test-PatternValid

## SYNOPSIS
Checks whether a pattern is valid.

## SYNTAX

```
Test-PatternValid [-Variable] <Object> [-Pattern] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Test-PatternValid" cmdlet checks if a pattern is valid and returns true on success.

## EXAMPLES

### BEISPIEL 1
```
Test-PatternValid -Variable "123 ABC" -Pattern "^[0-9]*\s[A-Z]*$"
```

## PARAMETERS

### -Variable
The variable that is to be checked with a pattern.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Pattern
The regex pattern that the variable is checked against.

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

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-PatternValid.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-PatternValid.md)

