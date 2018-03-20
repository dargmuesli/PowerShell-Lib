---
external help file: TextLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Join-MultiLineStrings.md
schema: 2.0.0
---

# Join-MultiLineStrings

## SYNOPSIS
Joins multi line strings.

## SYNTAX

```
Join-MultiLineStrings [-MultiLineStrings] <String[]> [-EOLCharacter <String>] [-Newline] [<CommonParameters>]
```

## DESCRIPTION
The "Join-MultiLineStrings" cmdlet iterates over all multi line strings, adding an optional newline between each and appending each to the return string.

## EXAMPLES

### EXAMPLE 1
```
$FileA = Get-Content -Path ".\FileA.md" -Raw
```

$FileB = Get-Content -Path ".\FileB.md" -Raw

Join-MultiLineStrings -MultiLineStrings @($FileA, $FileB) -Newline

## PARAMETERS

### -MultiLineStrings
The multi line strings that are to be joined.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -EOLCharacter
End of line character.
Either "\`r", "\`n" or \`r\`n".
Default is "\`n".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Newline
Whether to insert a newline between each string.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Join-MultiLineStrings.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Join-MultiLineStrings.md)

