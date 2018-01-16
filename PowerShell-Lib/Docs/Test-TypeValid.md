---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-TypeValid.md
schema: 2.0.0
---

# Test-TypeValid

## SYNOPSIS
Checks whether a variable's values are of a given type.

## SYNTAX

```
Test-TypeValid [-Variable] <Object> [-Type] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Test-TypeValid" cmdlet checks if a variable's values are of a given type and returns true on succcess.

## EXAMPLES

### BEISPIEL 1
```
Test-TypeValid -Variable @(123) -Type Int
```

## PARAMETERS

### -Variable
The variable that is to be checked.

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

### -Type
The type of which the variable's values have to be of.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-TypeValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-TypeValid.md)

