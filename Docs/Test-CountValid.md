---
external help file: ValidationLib-help.xml
Module Name: powershell-lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-CountValid.md
schema: 2.0.0
---

# Test-CountValid

## SYNOPSIS
Checks whether the count of a variable's values is in a specified range.

## SYNTAX

```
Test-CountValid [-Variable] <Array> [-Min] <Int32> [-Max] <Int32>
```

## DESCRIPTION
The "Test-CountValid" cmdlet checks if the count of a variable's values is in a specified range and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-CountValid -Variable @(@(1, 2), @(3, 4)) -Min 0 -Max 2
```

## PARAMETERS

### -Variable
The variable that is to be checked.

```yaml
Type: Array
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Min
The minimum count to allow.

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
The maximum count to allow.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-CountValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-CountValid.md)

