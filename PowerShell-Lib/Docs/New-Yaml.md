---
external help file: YamlDotNetLib-help.xml
Module Name: PowerShell-Lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/New-Yaml.md
schema: 2.0.0
---

# New-Yaml

## SYNOPSIS
Creates a Yaml string.

## SYNTAX

```
New-Yaml [-Value] <Object>
```

## DESCRIPTION
The "New-Yaml" cmdlet serializes and returns a value by creating a SerializerBuilder.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
New-Yaml -Value @{"hello"="world"; "quoted"=New-DoubleQuotedString("bar"); "anArray"=@(1,2,3); "nested"=@{"array"=@("this", "is", "an", "array")}}
```

## PARAMETERS

### -Value
The value that is to be serialized.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/New-Yaml.md](https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/New-Yaml.md)

