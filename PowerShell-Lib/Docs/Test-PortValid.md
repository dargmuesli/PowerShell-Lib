---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-PortValid.md
schema: 2.0.0
---

# Test-PortValid

## SYNOPSIS
Checks whether a port is valid.

## SYNTAX

```
Test-PortValid [-Port] <Object>
```

## DESCRIPTION
The "Test-PortValid" cmdlet tries to match a port with a regex pattern for valid ports and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-PortValid -Port "8080"
```

## PARAMETERS

### -Port
The port that is to be checked.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-PortValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Test-PortValid.md)

