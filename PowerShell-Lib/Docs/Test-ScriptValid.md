---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-ScriptValid.md
schema: 2.0.0
---

# Test-ScriptValid

## SYNOPSIS
Checks whether a script validifies a variable's values.

## SYNTAX

```
Test-ScriptValid [-Variable] <Object> [-Script] <ScriptBlock>
```

## DESCRIPTION
The "Test-ScriptValid" cmdlet checks if a script validifies a variable's values and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-ScriptValid -Variable @(5) -Script "If ($PSItem -Eq 5) { Return $True } Else { Return $False }"
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-ScriptValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-ScriptValid.md)

