---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Install-PackageOnce.md
schema: 2.0.0
---

# Install-PackageOnce

## SYNOPSIS
Installs a package only if it is not already installed.

## SYNTAX

```
Install-PackageOnce [-Name] <String[]> [-Destination <String>]
```

## DESCRIPTION
The "Install-PackageOnce" cmdlet checks whether a package is already installed and installs it if not.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Install-PackageOnce -Name "YamlDotNet"
```

## PARAMETERS

### -Name
The name of the package that is to be installed.

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

### -Destination
The install destination.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Install-PackageOnce.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Install-PackageOnce.md)

