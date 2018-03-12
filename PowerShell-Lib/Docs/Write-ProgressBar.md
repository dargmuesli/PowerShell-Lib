---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Write-ProgressBar.md
schema: 2.0.0
---

# Write-ProgressBar

## SYNOPSIS
Displays a progress bar.

## SYNTAX

```
Write-ProgressBar [-PercentComplete] <Int32> [-Activity <String>] [<CommonParameters>]
```

## DESCRIPTION
The "Write-ProgressBar" cmdlet displays a progress bar with a given progress percentage and a description of the currently running activity.

## EXAMPLES

### EXAMPLE 1
```
Write-ProgressBar -Activity "Checking ..." -PercentComplete $Index
```

## PARAMETERS

### -PercentComplete
The progress of the progress bar.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Write-ProgressBar.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Write-ProgressBar.md)

