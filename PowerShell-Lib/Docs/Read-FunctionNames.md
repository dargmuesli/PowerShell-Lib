---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Read-FunctionNames.md
schema: 2.0.0
---

# Read-FunctionNames

## SYNOPSIS
Reads all PowerShell function names from a string.

## SYNTAX

```
Read-FunctionNames [-InputString] <String>
```

## DESCRIPTION
The "Read-FunctionNames" cmdlet parses the input string and returns all findings of function names inside it.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
$InputString = @"
```

Function X {
        $a = 1
    }
    Function Y {
        $b = 2
    }
"@

Read-FunctionNames -InputString $InputString

## PARAMETERS

### -InputString
The string that is to be searched through.

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

## INPUTS

## OUTPUTS

### Sorted by the functions' order of occurrence.

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Read-FunctionNames.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Read-FunctionNames.md)

