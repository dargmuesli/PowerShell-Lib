---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Install-ModuleOnce.md
schema: 2.0.0
---

# Install-ModuleOnce

## SYNOPSIS
Installs a module only if it is not already installed.

## SYNTAX

```
Install-ModuleOnce [-Name] <String[]> [[-Scope] <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
The "Install-ModuleOnce" cmdlet checks whether a module is already installed and installs it if not.

## EXAMPLES

### EXAMPLE 1
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
Defaults to "AllUsers" when in an elevated session on Windows, to "CurrentUser" otherwise.

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

### -Force
Whether to force the installation.

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

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Install-ModuleOnce.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Install-ModuleOnce.md)

