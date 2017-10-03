---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Write-ProgressBar.md
schema: 2.0.0
---

# Write-ProgressBar

## SYNOPSIS
Displays a progress bar.

## SYNTAX

```
Write-ProgressBar [-PercentComplete] <Int32> [-Activity <String>]
```

## DESCRIPTION
The "Write-ProgressBar" cmdlet displays a progress bar with a given progress percentage and a description of the currently running activity.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Write-ProgressBar.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Write-ProgressBar.md)

