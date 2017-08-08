---
external help file: PowerShellLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Write-Progressbar

## SYNOPSIS
Displays a progressbar.

## SYNTAX

```
Write-Progressbar [-PercentComplete] <Int32> [-Activity <String>] [<CommonParameters>]
```

## DESCRIPTION
The "Write-Progressbar" cmdlet displays a progressbar with a given progress percentage and a description of the currently running activity.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Write-Progressbar -Activity "Checking ..." -PercentComplete $Index
```

## PARAMETERS

### -PercentComplete
The progress of the progressbar.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Activity
A description of the activity that is running.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Processing
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

