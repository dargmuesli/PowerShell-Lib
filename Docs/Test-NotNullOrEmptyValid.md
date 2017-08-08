---
external help file: ValidationLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-NotNullOrEmptyValid

## SYNOPSIS
Check if a variable is not null and not empty.

## SYNTAX

```
Test-NotNullOrEmptyValid [-Variable] <Array> [<CommonParameters>]
```

## DESCRIPTION
The "Test-NotNullOrEmptyValid" cmdlet checks if a variable's values are not null or empty and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-NotNullOrEmptyValid -Variable @(123)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

