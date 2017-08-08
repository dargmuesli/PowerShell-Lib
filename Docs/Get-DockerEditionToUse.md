---
external help file: DockerLib-help.xml
online version: Source: https://stackoverflow.com/a/31714410
schema: 2.0.0
---

# Get-DockerEditionToUse

## SYNOPSIS
Returns the Docker edition name that is to be used.

## SYNTAX

```
Get-DockerEditionToUse [<CommonParameters>]
```

## DESCRIPTION
The "Get-DockerEditionToUse" cmdlet test if Docker for Windows and Docker Toolbox are installed.
If only one is installed, that one is returned.
If both are installed, the user is asked which one is the user's preferred choice.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Get-DockerEditionToUse
```

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Either "ForWin" or "Toolbox".

## NOTES

## RELATED LINKS

