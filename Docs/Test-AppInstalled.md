---
external help file: AppLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-AppInstalled

## SYNOPSIS
Checks if an app in installed on the current computer.

## SYNTAX

```
Test-AppInstalled [-AppName] <String> [-RegexCompare] [<CommonParameters>]
```

## DESCRIPTION
The "Test-AppInstalled" cmdlet gets a list of all installed apps and checks if the value of parameter "AppName" occurs within the list.
If that is the case, "True" is returned.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-AppInstalled -AppName "Docker Toolbox version \d+\.\d+\.\d+(-ce)*" -RegexCompare
```

## PARAMETERS

### -AppName
The app name to check.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RegexCompare
Whether to match the app name literally or by using patterns.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

