---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Set-ArrayItem.md
schema: 2.0.0
---

# Set-ArrayItem

## SYNOPSIS
Sets an array item.

## SYNTAX

```
Set-ArrayItem [-Array] <Object> [-NewItem] <Object> [[-OldItem] <Object>] [<CommonParameters>]
```

## DESCRIPTION
The "Set-ArrayItem" cmdlet either replaces an old item with a new one or simply adds a new one to an existing array.

## EXAMPLES

### BEISPIEL 1
```
Set-ArrayItem -Array @(1, 3) -NewItem 2
```

## PARAMETERS

### -Array
The array to perform the operations on.

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

### -NewItem
The item that is to be inserted.

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

### -OldItem
The item that is to be overridden.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Set-ArrayItem.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Set-ArrayItem.md)

