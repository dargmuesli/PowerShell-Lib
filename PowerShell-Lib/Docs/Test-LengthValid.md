---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-LengthValid.md
schema: 2.0.0
---

# Test-LengthValid

## SYNOPSIS
Checks whether the length of a variable's values is in a specified range.

## SYNTAX

```
Test-LengthValid [-Variable] <Object> [-Min] <Int32> [-Max] <Int32>
```

## DESCRIPTION
The "Test-LengthValid" cmdlet checks if the length of a variable's values is in a specified range and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-LengthValid -Variable @("123", "456") -Min 0 -Max 3
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-LengthValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-LengthValid.md)

