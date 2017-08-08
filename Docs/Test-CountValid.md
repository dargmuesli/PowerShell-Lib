---
external help file: ValidationLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-CountValid

## SYNOPSIS
Checks if the count of a variable's values is in a specified range.

## SYNTAX

```
Test-CountValid [-Variable] <Array> [-Min] <Int32> [-Max] <Int32> [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

