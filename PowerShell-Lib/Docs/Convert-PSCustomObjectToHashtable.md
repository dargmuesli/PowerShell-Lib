---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Convert-PSCustomObjectToHashtable.md
schema: 2.0.0
---

# Convert-PSCustomObjectToHashtable

## SYNOPSIS
Converts a PSCustomObject to a hashtable.

## SYNTAX

```
Convert-PSCustomObjectToHashtable [-InputObject] <PSObject>
```

## DESCRIPTION
The "Convert-PSCustomObjectToHashtable" cmdlet iterates over a PSCustomObject's properties and adds name-value pairs to a hastable that it returns.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Convert-PSCustomObjectToHashtable -InputObject $InputObject
```

## PARAMETERS

### -InputObject
The PSCustomObject that is to be converted.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Convert-PSCustomObjectToHashtable.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Convert-PSCustomObjectToHashtable.md)

