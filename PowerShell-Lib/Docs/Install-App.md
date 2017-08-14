---
external help file: AppLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Install-App.md
schema: 2.0.0
---

# Install-App

## SYNOPSIS
Installs an app on the current computer.

## SYNTAX

```
Install-App [-InstallerPath] <String>
```

## DESCRIPTION
The "Install-App" cmdlet starts an type-dependent installer and waits for its completion.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Install-App -InstallerPath ".\installer.msi"
```

## PARAMETERS

### -InstallerPath
The path to where the installer is located.
File extensions ".exe" and ".msi" are supported.

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

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Install-App.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Install-App.md)

