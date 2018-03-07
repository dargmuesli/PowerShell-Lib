---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-RangeValid.md
schema: 2.0.0
---

# Test-RangeValid

## SYNOPSIS
Checks whether a variable's values are in a specified range.

## SYNTAX

```
Test-RangeValid [-Variable] <Object> [-Min] <Int32> [-Max] <Int32> [<CommonParameters>]
```

## DESCRIPTION
The "Test-CountValid" cmdlet checks if a variable's values are in a specified range and returns true on success.

## EXAMPLES

### BEISPIEL 1
```
Test-RangeValid -Variable @(1, 2, 3) -Min 0 -Max 3
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

### -Min
The minimum value to allow.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Max
The maximum value to allow.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: 0
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

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-RangeValid.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-RangeValid.md)

