---
external help file: ValidationLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-HostnameValid.md
schema: 2.0.0
---

# Test-HostnameValid

## SYNOPSIS
Checks whether a hostname is valid.

## SYNTAX

```
Test-HostnameValid [-Hostname] <String[]>
```

## DESCRIPTION
The "Test-HostnameValid" cmdlet tries to match a hostname with a regex pattern for valid hostnames and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-HostnameValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-HostnameValid.md)

