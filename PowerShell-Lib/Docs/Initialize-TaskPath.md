---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Initialize-TaskPath.md
schema: 2.0.0
---

# Initialize-TaskPath

## SYNOPSIS
Ensures that a path does not already exist.

## SYNTAX

```
Initialize-TaskPath [-TaskPath] <String> [-Overwrite] [<CommonParameters>]
```

## DESCRIPTION
The "Initialize-TaskPath" cmdlet checks whether a path exists and, depending on the "Overwrite" flag, deletes that path or throws an error.

## EXAMPLES

### BEISPIEL 1
```
Initialize-TaskPath -TaskPath "~\Project\Output.txt"
```

## PARAMETERS

### -TaskPath
The path that is to be checked.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Overwrite
Whether to remove the given path.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Initialize-TaskPath.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Initialize-TaskPath.md)

