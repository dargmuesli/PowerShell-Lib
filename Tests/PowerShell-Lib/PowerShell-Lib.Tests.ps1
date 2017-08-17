Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force

Describe "PowerShell-Lib" {
    Context 'Format' {
        $NestedModules = (Get-Module PowerShell-Lib).NestedModules
        $NestedModulesFunctionsLists = [Ordered] @{}
        $NestedModulesFunctionsListsSorted = [Ordered] @{}
        $NestedModulesFunctionsHelpLists = [Ordered] @{}

        ForEach ($NestedModule In $NestedModules) {
            Import-Module -Name $NestedModule.Path -Force

            $NestedModulesContent = Get-Content -Path $NestedModule.Path -Raw
            $NestedModulesFunctionsLists[$NestedModule.Name] = Read-FunctionNames -InputString $NestedModulesContent
            $NestedModulesFunctionsListsSorted[$NestedModule.Name] = Read-FunctionNames -InputString $NestedModulesContent | Sort-Object

            $NestedModulesFunctionsHelpLists[$NestedModule.Name] = [Ordered] @{}
            $NestedModulesFunctions = $NestedModulesFunctionsLists.Get_Item($NestedModule.Name)

            ForEach ($NestedModulesFunction In $NestedModulesFunctions) {
                $NestedModulesFunctionsHelpLists.Get_Item($NestedModule.Name)[$NestedModulesFunction] = Get-Help -Name $NestedModulesFunction -Full
            }
        }

        It "contains functions in alphabetical order" {
            Compare-Object -ReferenceObject (
                $NestedModulesFunctionsLists | ConvertTo-Json
            ) -DifferenceObject (
                $NestedModulesFunctionsListsSorted | ConvertTo-Json
            ) | Should BeNullOrEmpty
        }

        It "has a correct `".LINK`" for each function's comment based help" {
            ForEach ($NestedModulesFunctionsHelpList In $NestedModulesFunctionsHelpLists.GetEnumerator()) {
                ForEach ($NestedModulesFunctionsHelp In $NestedModulesFunctionsHelpList.Value.GetEnumerator()) {
                    $TestPropertyExists = Test-PropertyExists -Object $NestedModulesFunctionsHelp.Value -PropertyName "relatedLinks.navigationLink.uri"
                    
                    If (-Not $TestPropertyExists) {
                        Write-Warning $NestedModulesFunctionsHelp.Key
                    }
                    
                    $TestPropertyExists | Should Be $True

                    $NestedModulesFunctionsHelp.Value.relatedLinks.navigationLink.uri |
                        Should Match "^https:\/\/github\.com\/Dargmuesli\/powershell-lib\/blob\/master\/Docs\/$($NestedModulesFunctionsHelp.Key)\.md$"
                }
            }
        }
    }
}
