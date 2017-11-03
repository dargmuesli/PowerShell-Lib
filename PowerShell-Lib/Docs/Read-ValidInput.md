---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Read-ValidInput.md
schema: 2.0.0
---

# Read-ValidInput

## SYNOPSIS
Reads valid input.

## SYNTAX

```
Read-ValidInput [-Prompt] <String> [-ValidityCheck] <ScriptBlock[]> [-ErrorMessage] <String[]>
```

## DESCRIPTION
The "Read-ValidInput" cmdlet checks the input against a script and displays a error message if the check fails.
It loops until a valid answer can be returned.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
$InputPath = Read-ValidInput `
```

-Prompt "The input path" \`
    -ValidityCheck @(
        {Test-Path $Answer}
    ) \`
    -ErrorMessage @(
        "Invalid path!"
    )

## PARAMETERS

### -Prompt
A description of the input that the user is asked for.

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

### -ValidityCheck
A script to validate the user's input.

```yaml
Type: ScriptBlock[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorMessage
The error message that is shown when the validation fails.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Read-ValidInput.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Read-ValidInput.md)

