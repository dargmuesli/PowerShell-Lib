---
external help file: PowerShellLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-FileFromWeb.md
schema: 2.0.0
---

# Get-FileFromWeb

## SYNOPSIS
Downloads a file from a URL.

## SYNTAX

```
Get-FileFromWeb [-Url] <String> [-LocalPath] <String> [-DownloadMethod <String>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
The "Get-FileFromWeb" cmdlet uses different methods to download a file from a URL and saves it to a desired location.

## EXAMPLES

### BEISPIEL 1
```
Get-FileFromWeb -Url "https://download.docker.com/win/stable/InstallDocker.msi" -LocalPath ".\"
```

## PARAMETERS

### -Url
The URL where the requested resource is located.

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

### -LocalPath
The path to where the requested file is to be saved to.

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

### -DownloadMethod
The download function that is to be used.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: BITS
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
{{Fill Credential Description}}

```yaml
Type: PSCredential
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
Download method "BITS" can display its progress, but can also be delayed by other downloads.
Download method "WebClient" cannot display its progress.
Download method "WebRequest" can display its progress, but is very slow.

## RELATED LINKS

[https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-FileFromWeb.md](https://github.com/Dargmuesli/PowerShell-Lib/blob/master/PowerShell-Lib/Docs/Get-FileFromWeb.md)

