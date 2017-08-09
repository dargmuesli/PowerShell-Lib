---
external help file: PowerShellLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-PropertyExists.md
schema: 2.0.0
---

# Test-PropertyExists

## SYNOPSIS
Checks whether an object's property exists.

## SYNTAX

```
Test-PropertyExists [-Object] <Object> [-PropertyName] <String>
```

## DESCRIPTION
The "Test-PropertyExists" cmdlet checks if an object contains a property name and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-PropertyExists -Object {test='123'} -PropertyName "test"
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-PropertyExists.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-PropertyExists.md)

