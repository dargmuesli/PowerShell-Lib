---
external help file: DockerLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-DockerStackRunning

## SYNOPSIS
Checks if a Docker stack is running.

## SYNTAX

```
Test-DockerStackRunning [-StackNamespace] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Test-DockerStackRunning" cmdlet looks for a running container with a matching "stack.namespace" property.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-DockerStackRunning -StackNamespace "AppStack"
```

## PARAMETERS

### -StackNamespace
The stack's name that is to be checked.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
