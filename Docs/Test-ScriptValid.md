---
external help file: ValidationLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-ScriptValid

## SYNOPSIS
Checks if a script validifies a variable's values.

## SYNTAX

```
Test-ScriptValid [-Variable] <Object> [-Script] <ScriptBlock> [<CommonParameters>]
```

## DESCRIPTION
The "Test-ScriptValid" cmdlet checks if a script validifies a variable's values and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-ScriptValid -Variable @(5) -Script "If ($PSItem = 5) { Return $True } Else { Return $False }"
```

## PARAMETERS

### -Variable
The variable that is to be checked.

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

### -Script
The script that checks the variable.

```yaml
Type: ScriptBlock
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
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
