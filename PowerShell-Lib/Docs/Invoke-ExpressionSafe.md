---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Invoke-ExpressionSafe.md
schema: 2.0.0
---

# Invoke-ExpressionSafe

## SYNOPSIS
Invokes an expression without causing crashes.

## SYNTAX

```
Invoke-ExpressionSafe [-Command] <String> [-WithHost] [-WithError] [-Graceful]
```

## DESCRIPTION
The "Invoke-ExpressionSafe" cmdlet Invokes the given command redirecting errors into a temporary file and other output into a variable.
If the WithError parameter is given, the temporary file's output is appended to stdout.
If the Graceful parameter is given and an error occurs, no exception is be thrown.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Invoke-ExpressionSafe -Command "docker swarm init --advertise-addr 'eth0:2377'" -WithError -Graceful
```

## PARAMETERS

### -Command
The expression to invoke safely.

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

### -WithHost
Whether to return the host message in stdout.

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

### -WithError
Whether to return the error message in stdout.

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

### -Graceful
Prevents that an error is thrown.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Invoke-ExpressionSafe.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Invoke-ExpressionSafe.md)

