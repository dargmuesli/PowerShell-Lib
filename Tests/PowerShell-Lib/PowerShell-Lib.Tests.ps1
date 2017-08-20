Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force

Describe "PowerShell-Lib" {
    $NestedModules = (Get-Module PowerShell-Lib).NestedModules

    ForEach ($NestedModule In $NestedModules) {
        Context $NestedModule {
            $ModuleFileContent = $Null
            $ModuleFunctionNames = $Null
            $ModuleFunctionNamesSorted = $Null

            Import-Module -Name $NestedModule.Path -Force
    
            $ModuleFileContent = Get-Content -Path $NestedModule.Path -Raw
            $ModuleFunctionNames = [Object[]] (Read-FunctionNames -InputString $ModuleFileContent)
            $ModuleFunctionNamesSorted = [Object[]] ($ModuleFunctionNames | Sort-Object)
            
            It "contains functions in alphabetical order" {
                $ModuleFunctionNames = $ModuleFunctionNames
                $ModuleFunctionNamesSorted = $ModuleFunctionNamesSorted

                For ($I = 0; $I -Lt $ModuleFunctionNames.Length; $I++) {
                    $ModuleFunctionNamesSorted.Get_Item($I) | Should Be $ModuleFunctionNames.Get_Item($I)
                }
            }
    
            ForEach ($ModuleFunctionName In $ModuleFunctionNamesSorted) {
                $ModuleFunctionsHelp = Get-Help -Name $ModuleFunctionName -Full

                It "has a correct `".LINK`" for function $($ModuleFunctionsHelp.Name)" {
                    Test-PropertyExists -Object $ModuleFunctionsHelp -PropertyName "relatedLinks.navigationLink.uri" |
                        Should Be $True
                
                    $ModuleFunctionsHelp.relatedLinks.navigationLink.uri |
                        Should Match "^https:\/\/github\.com\/Dargmuesli\/powershell-lib\/blob\/master\/Docs\/$($ModuleFunctionsHelp.Name)\.md$"
                }
            }
        }
    }
}
