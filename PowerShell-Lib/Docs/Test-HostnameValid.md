---
external help file: ValidationLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-HostnameValid.md
schema: 2.0.0
---

# Test-HostnameValid

## SYNOPSIS
Checks whether a hostname is valid.

## SYNTAX

```
Test-HostnameValid [-Hostname] <String[]> [<CommonParameters>]
```

## DESCRIPTION
The "Test-HostnameValid" cmdlet tries to match a hostname with a regex pattern for valid hostnames and returns true on success.

## EXAMPLES

### BEISPIEL 1
```
Test-HostnameValid -Hostname "test-hostname"
```

## PARAMETERS

### -Hostname
The hostname that is to be checked.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-HostnameValid.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Test-HostnameValid.md)

