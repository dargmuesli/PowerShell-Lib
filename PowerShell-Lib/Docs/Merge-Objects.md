---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Merge-Objects.md
schema: 2.0.0
---

# Merge-Objects

## SYNOPSIS
Merges two objects into one.

## SYNTAX

```
Merge-Objects [-Object1] <Object> [-Object2] <Object>
```

## DESCRIPTION
The "Merge-Objects" cmdlet adds all properties of the first object and the second object to a third one and returns the latter.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Merge-Objects -Object1 @{test='123'} -Object2 @{123='test'}
```

## PARAMETERS

### -Object1
The first source object.

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

### -Object2
The second source object.

```yaml
Type: Object
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

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Merge-Objects.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Merge-Objects.md)

