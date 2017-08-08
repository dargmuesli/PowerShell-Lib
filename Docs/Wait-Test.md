---
external help file: PowerShellLib-help.xml
online version: Source: https://gist.github.com/au-phiware/25213e72c80040f398ba
schema: 2.0.0
---

# Wait-Test

## SYNOPSIS
Displays an indeterminate progressbar while a test is successful.

## SYNTAX

```
Wait-Test [-Test] <String> [-Activity <String>] [-Milliseconds <Int32>] [-WithProgressbar] [<CommonParameters>]
```

## DESCRIPTION
The "Wait-Test" cmdlet increases the progressbar's value in steps from 0 to 100 infinitly to provide visual feedback about a running task to the user.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Wait-Test -Test "-Not (Test-DockerRunning)" -Activity "Waiting for Docker to initialize" -WithProgressbar
```

## PARAMETERS

### -Test
The task check which needs to pass.

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

### -Activity
A description of the running task.

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: Processing
Accept pipeline input: False
Accept wildcard characters: False
```

### -Milliseconds
The time to wait between test checks.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 1000
Accept pipeline input: False
Accept wildcard characters: False
```

### -WithProgressbar
Wether to display a progressbar.

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
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

