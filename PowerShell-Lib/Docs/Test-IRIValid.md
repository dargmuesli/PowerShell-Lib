---
external help file: ValidationLib-help.xml
Module Name: powershell-lib
online version: https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-IRIValid.md
schema: 2.0.0
---

# Test-IRIValid

## SYNOPSIS
Checks whether an IRI is valid.

## SYNTAX

```
Test-IRIValid [-IRI] <String[]>
```

## DESCRIPTION
The "Test-IRIValid" cmdlet tries to match an IRI with a regex pattern for valid IRIs and returns true on success.

## EXAMPLES

### -------------------------- BEISPIEL 1 --------------------------
```
Test-IRIValid -IRI "google.com"
```

## PARAMETERS

### -IRI
The IRI that is to be checked.

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

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-IRIValid.md](https://github.com/Dargmuesli/powershell-lib/blob/master/Docs/Test-IRIValid.md)

