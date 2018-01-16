---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-SetValid.md
schema: 2.0.0
---

# Test-SetValid

## SYNOPSIS
Checks whether a variable's values exist within a set.

## SYNTAX

```
Test-SetValid [-Variable] <Object> [-Set] <Array> [<CommonParameters>]
```

## DESCRIPTION
The "Test-SetValid" cmdlet checks if a variable's values exist within a set and return true on success.

## EXAMPLES

### BEISPIEL 1
```
Test-SetValid -Variable @("test", "123") -Set @("test", "123", "foo", "bar")
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

### -Set
The set that contains the variables that are allowed to appear within the variable.

```yaml
Type: Array
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

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-SetValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-SetValid.md)

