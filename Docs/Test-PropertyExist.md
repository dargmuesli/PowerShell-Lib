---
external help file: PowerShellLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-PropertyExist

## SYNOPSIS
Checks if an object's property exists.

## SYNTAX

```
Test-PropertyExist [-Object] <Object> [-PropertyName] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Test-PropertyExist" cmdlet checks if an object contains a property name and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-PropertyExist -Object {test='123'} -PropertyName "test"
```

## PARAMETERS

### -Object
The object that is to be checked for properties.

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

### -PropertyName
The object's property name that is to be checked.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

