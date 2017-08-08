---
external help file: DockerLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Test-DockerMachineExist

## SYNOPSIS
Checks if a Docker Machine exists.

## SYNTAX

```
Test-DockerMachineExist [-MachineName] <String> [<CommonParameters>]
```

## DESCRIPTION
The "Test-DockerMachineExist" cmdlet tries to show information about the Docker Machine and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-DockerMachineExist -MachineName "Docker"
```

## PARAMETERS

### -MachineName
The name of the virtual machine that is to be checked.

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

