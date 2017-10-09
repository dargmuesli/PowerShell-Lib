Set-StrictMode -Version Latest

<#
    .SYNOPSIS
    Returns a double quoted string.

    .DESCRIPTION
    The "New-DoubleQuotedString" cmdlet creates and returns a new YamlScalarNode, double quote style.

    .PARAMETER String
    The string to set the style for.

    .EXAMPLE
    New-DoubleQuotedString -Value "foo"

    .NOTES
    Source: https://github.com/aaubry/YamlDotNet/pull/239#issuecomment-335000781

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/New-DoubleQuotedString.md
#>
Function New-DoubleQuotedString {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $String
    )

    $Scalar = [YamlDotNet.RepresentationModel.YamlScalarNode]::New($String)
    $Scalar.Style = [YamlDotNet.Core.ScalarStyle]::DoubleQuoted

    Return $Scalar
}

<#
    .SYNOPSIS
    Creates a Yaml string.

    .DESCRIPTION
    The "New-Yaml" cmdlet serializes and returns a value by creating a SerializerBuilder.

    .PARAMETER Value
    The value that is to be serialized.

    .EXAMPLE
    New-Yaml -Value @{"hello"="world"; "quoted"=New-DoubleQuotedString("bar"); "anArray"=@(1,2,3); "nested"=@{"array"=@("this", "is", "an", "array")}}

    .LINK
    https://github.com/Dargmuesli/powershell-lib/blob/master/PowerShell-Lib/Docs/New-Yaml.md
#>
Function New-Yaml {
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        $Value
    )

    $Serializer = [YamlDotNet.Serialization.SerializerBuilder]::New().Build()
    Return $Serializer.Serialize($Value).Trim("`r`n")
}

Export-ModuleMember -Function *
