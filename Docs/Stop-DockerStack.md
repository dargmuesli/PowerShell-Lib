---
external help file: DockerLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerStack.md
schema: 2.0.0
---

# Stop-DockerStack

## SYNOPSIS
Stops a Docker stack.

## SYNTAX

```
Stop-DockerStack [-StackName] <String>
```

## DESCRIPTION
The "Stop-DockerStack" cmdlet stops a Docker stack and waits for all included containers to stop.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Stop-DockerStack -StackName "appstack"
```

## PARAMETERS

### -StackName
The name of the stack to is to be stopped.

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

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerStack.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Stop-DockerStack.md)

