---
external help file: PowerShellLib-help.xml
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Invoke-WebRequestWithProgress.md
schema: 2.0.0
---

# Invoke-WebRequestWithProgress

## SYNOPSIS
Download a file and displays a progress bar.

## SYNTAX

```
Invoke-WebRequestWithProgress [-Uri] <Uri> [-OutFile] <String> [-Overwrite] [-Timeout <Int32>]
```

## DESCRIPTION
The "Invoke-WebRequestWithProgress" cmdlet creates a HttpWebRequest whose response stream is directed to a file.
Every 10KB a progress bar showing the current download progress is displayed/updated.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Invoke-WebRequestWithProgress -Uri "https://download.docker.com/win/stable/InstallDocker.msi" -OutFile ".\"
```

## PARAMETERS

### -Uri
The URI of the file that is to be downloaded.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -OutFile
The path to where the file is to be saved to.

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

### -Overwrite
Whether to overwrite an already existing downloaded file.

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

### -Timeout
How long to wait for a connection success.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: False
Position: Named
Default value: 15000
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Invoke-WebRequestWithProgress.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Invoke-WebRequestWithProgress.md)

