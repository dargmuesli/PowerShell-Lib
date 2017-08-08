---
external help file: PowerShellLib-help.xml
online version: Source: https://stackoverflow.com/a/31714410
schema: 2.0.0
---

# Read-PromptYesNo

## SYNOPSIS
Displays a yes/no prompt.

## SYNTAX

```
Read-PromptYesNo [-Caption] <String> [-Message] <String> [-DefaultChoice <Int32>] [<CommonParameters>]
```

## DESCRIPTION
The "Read-PromptYesNo" cmdlet displays a yes/no prompt and waits for the user's choice.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Read-PromptYesNo -Message "Docker is not installed." -Question "Do you want to install it automatically?" -DefaultChoice 0
```

## PARAMETERS

### -Caption
The caption that is to be displayed.

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

### -Message
The message that is to be displayed.

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

### -DefaultChoice
The choice that is selected by default.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

