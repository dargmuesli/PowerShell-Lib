---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Write-ErrorRecord.md
schema: 2.0.0
---

# Write-ErrorRecord

## SYNOPSIS
Writes an error record.

## SYNTAX

```
Write-ErrorRecord [-Exception] <String> [-ErrorId] <String> [-ErrorCategory] <ErrorCategory>
 [-TargetObject] <Object> [-Message <String>] [-InnerException <Exception>] [<CommonParameters>]
```

## DESCRIPTION
Creates a custom error record and writes a non-terminating error.

## EXAMPLES

### BEISPIEL 1
```
$Content = Get-Content -LiteralPath $Path -ErrorAction "SilentlyContinue"
```

If (-Not $Content) {
    New-ErrorRecord -Exception "InvalidOperationException" -ErrorId "FileIsEmpty" -ErrorCategory "InvalidOperation" -TargetObject $Path -Message "File '$Path' is empty." -InnerException $Error\[0\].Exception
}

## PARAMETERS

### -Exception
The exception that will be associated with the error record.

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

### -ErrorId
The error's identifier that must be a non-localized string for a specific error type.

```yaml
Type: String
Parameter Sets: (All)
Aliases: ID

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ErrorCategory
An error category enumeration that defines the category of the error.

```yaml
Type: ErrorCategory
Parameter Sets: (All)
Aliases: Category
Accepted values: NotSpecified, OpenError, CloseError, DeviceError, DeadlockDetected, InvalidArgument, InvalidData, InvalidOperation, InvalidResult, InvalidType, MetadataError, NotImplemented, NotInstalled, ObjectNotFound, OperationStopped, OperationTimeout, SyntaxError, ParserError, PermissionDenied, ResourceBusy, ResourceExists, ResourceUnavailable, ReadError, WriteError, FromStdErr, SecurityError, ProtocolError, ConnectionError, AuthenticationError, LimitsExceeded, QuotaExceeded, NotEnabled

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TargetObject
The object that was being processed when the error occurred.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Message
The exception's description.

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

### -InnerException
The exception instance that caused the exception association with the error record.

```yaml
Type: Exception
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable.
For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Source: https://gist.github.com/wpsmith/e8a9c54ca1c7c741b5e9

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Write-ErrorRecord.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/Write-ErrorRecord.md)

