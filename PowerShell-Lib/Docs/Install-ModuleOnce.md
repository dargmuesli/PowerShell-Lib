---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Install-ModuleOnce.md
schema: 2.0.0
---

# Install-ModuleOnce

## SYNOPSIS
Installs a module only if it is not already installed.

## SYNTAX

```
Install-ModuleOnce [-Name] <String[]> [[-Scope] <String>]
```

## DESCRIPTION
The "Install-ModuleOnce" cmdlet checks whether a module is already installed and installs it if not.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Install-ModuleOnce -Name "Pester"
```

## PARAMETERS

### -Name
The name of the module that is to be installed.

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

### -Scope
The installation scope.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Install-ModuleOnce.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Install-ModuleOnce.md)
