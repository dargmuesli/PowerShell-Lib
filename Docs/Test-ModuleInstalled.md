---
external help file: PowerShellLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-ModuleInstalled

## SYNOPSIS
Checks if a PowerShell module is installed.

## SYNTAX

```
Test-ModuleInstalled [-ModuleName] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Test-ModuleInstalled" cmdlet tries to get the desired module and return true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-ModuleInstalled -ModuleName "powershell-lib"
```

## PARAMETERS

### -ModuleName
The module's name that is to be checked.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

