---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Write-MultiColor.md
schema: 2.0.0
---

# Write-MultiColor

## SYNOPSIS
Write multicolored text.

## SYNTAX

```
Write-MultiColor [-Text] <String[]> [-Color] <ConsoleColor[]> [-StartTab <Int32>] [-LinesBefore <Int32>]
 [-LinesAfter <Int32>] [-LogFile <String>] [-TimeFormat <Object>] [<CommonParameters>]
```

## DESCRIPTION
The "Write-MultiColor" cmdlet writes indented and multicolored text to the console and optionally to a log file.

## EXAMPLES

### EXAMPLE 1
```
Write-MultiColor -Text "Red ", "Green ", "Yellow " -Color Red, Green, Yellow
```

Write-MultiColor -Text "This is text in Green ",
                "followed by Red ",
                "and then we have Magenta...
",
                "isn't it fun?
",
                "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan

Write-MultiColor -Text "This is text in Green ",
                "followed by Red ",
                "and then we have Magenta...
",
                "isn't it fun?
",
                "Here goes DarkCyan" -Color Green,Red,Magenta,White,DarkCyan -StartTab 3 -LinesBefore 1 -LinesAfter 1

Write-MultiColor "1.
", "Option 1" -Color Yellow, Green
Write-MultiColor "2.
", "Option 2" -Color Yellow, Green
Write-MultiColor "3.
", "Option 3" -Color Yellow, Green
Write-MultiColor "4.
", "Option 4" -Color Yellow, Green
Write-MultiColor "9.
", "Press 9 to exit" -Color Yellow, Gray -LinesBefore 1

Write-MultiColor -LinesBefore 2 -Text "This little ","message is ", "written to log ", "file as well." -Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt" -TimeFormat "yyyy-MM-dd HH:mm:ss"
Write-MultiColor -Text "This can get ","handy if you ", "want to display things, and log actions to file ", "at the same time." -Color Yellow, White, Green, Red, Red -LogFile "C:\testing.txt"

## PARAMETERS

### -Text
The text that is to be written.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Color
The color in which the text is to be written.

```yaml
Type: ConsoleColor[]
Parameter Sets: (All)
Aliases:
Accepted values: Black, DarkBlue, DarkGreen, DarkCyan, DarkRed, DarkMagenta, DarkYellow, Gray, DarkGray, Blue, Green, Cyan, Red, Magenta, Yellow, White

Required: True
Position: 1
Default value: White
Accept pipeline input: False
Accept wildcard characters: False
```

### -StartTab
The number of tabs to indent the text with.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesBefore
The number of empty lines before the text.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LinesAfter
The number of empty lines after the text.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -LogFile
The path to the log file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeFormat
The time format for logging.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: Yyyy-MM-dd HH:mm:ss
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Source: https://stackoverflow.com/a/36519870/4682621

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Write-MultiColor.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Write-MultiColor.md)

