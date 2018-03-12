---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Convert-PSCustomObjectToHashtable.md
schema: 2.0.0
---

# Convert-PSCustomObjectToHashtable

## SYNOPSIS
Converts a PSCustomObject to a hashtable.

## SYNTAX

```
Convert-PSCustomObjectToHashtable [-InputObject] <PSObject> [-YamlDotNet_DoubleQuoted] [<CommonParameters>]
```

## DESCRIPTION
The "Convert-PSCustomObjectToHashtable" cmdlet iterates over a PSCustomObject's properties and adds name-value pairs to a hastable that it returns.

## EXAMPLES

### EXAMPLE 1
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

### -YamlDotNet_DoubleQuoted
Toggle strings to have the YamlDotNet ScaralStyle "DoubleQuoted".

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Convert-PSCustomObjectToHashtable.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Convert-PSCustomObjectToHashtable.md)

