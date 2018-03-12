Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\YamlDotNetLib.psm1" -Force

If (-Not (Test-TypeLoaded -Name "YamlDotNet.RepresentationModel.YamlScalarNode")) {
    Add-Type -Path (Get-ChildItem -Path "${PSScriptRoot}\..\..\..\Packages" -Filter "YamlDotNet.dll" -Recurse -Force)[0].FullName
}

Describe "New-DoubleQuotedString" {
    It "returns a double quoted string" {
        $DoubleQuotedString = New-DoubleQuotedString -String "foo"

        $DoubleQuotedString | Should BeOfType [YamlDotNet.RepresentationModel.YamlScalarNode]
        $DoubleQuotedString | Should Be "foo"
        $DoubleQuotedString.Style | Should Be "DoubleQuoted"
    }
}

Describe "New-Yaml" {
    It "returns a Yaml string" -TestCases @(
        @{
            InputValue  = @{"hello" = "world"}
            ReturnValue = @"
hello: world
"@
        }
        @{
            InputValue  = @{"quoted" = New-DoubleQuotedString("bar")}
            ReturnValue = @"
quoted: "bar"
"@
        }
        @{
            InputValue  = @{"anArray" = @(1, 2, 3)}
            ReturnValue = @"
anArray:
- 1
- 2
- 3
"@
        }
        @{
            InputValue  = @{"nested" = @{"array" = @("this", "is", "an", "array")}}
            ReturnValue = @"
nested:
  array:
  - this
  - is
  - an
  - array
"@
        }
    ) {
        Param ($InputValue, $ReturnValue)

        New-Yaml -Value $InputValue | Should Be $ReturnValue
    }
}
