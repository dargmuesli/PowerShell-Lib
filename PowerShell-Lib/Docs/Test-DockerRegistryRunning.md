---
external help file: DockerLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerRegistryRunning.md
schema: 2.0.0
---

# Test-DockerRegistryRunning

## SYNOPSIS
Checks whether Docker runs a registry container.

## SYNTAX

```
Test-DockerRegistryRunning [-Hostname] <String> [-Port] <String>
```

## DESCRIPTION
The "Test-DockerRegistryRunning" cmdlet tries to invoke a web request to the registry's catalog and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-DockerRegistryRunning -Hostname "localhost" -Port "8080"
```

## PARAMETERS

### -Hostname
The hostname the registry is supposed to run on.

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

### -Port
The port the registry is supposed to run on.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerRegistryRunning.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-DockerRegistryRunning.md)

