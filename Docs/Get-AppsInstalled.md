---
external help file: AppLib-help.xml
online version: Source: https://stackoverflow.com/a/31714410
schema: 2.0.0
---

# Get-AppsInstalled

## SYNOPSIS
Returns a list of installed apps on the current computer.

## SYNTAX

```
Get-AppsInstalled [[-SelectObjectProperty] <Object>] [[-SortObjectProperty] <Object>] [<CommonParameters>]
```

## DESCRIPTION
The "Get-AppsInstalled" cmdlet gets the registry's uninstall keys depending on the system's architecture.
Then it filters all subkeys by the existence of a "DisplayName" and properties given in the "SelectObjectProperty" parameter.
Finally it sorts all found apps by their "DisplayName" and returns them.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Get-AppsInstalled -SelectObjectProperty @("DisplayName", "DisplayVersion") -SortObjectProperty @("DisplayName", "DisplayVersion")
```

## PARAMETERS

### -SelectObjectProperty
The properties to select.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 1
Default value: @("DisplayName")
Accept pipeline input: False
Accept wildcard characters: False
```

### -SortObjectProperty
The properties to sort by.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: @("DisplayName")
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[Source: https://stackoverflow.com/a/31714410](Source: https://stackoverflow.com/a/31714410)

