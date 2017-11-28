Set-StrictMode -Version Latest

Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\PowerShell-Lib.psd1" -Force
Import-Module -Name "${PSScriptRoot}\..\..\..\PowerShell-Lib\Modules\PowerShellLib.psm1" -Force

Describe "Convert-PSCustomObjectToHashtable" {
    It "converts a <InputObject> to a <OutputObject>" -TestCases @(
        @{
            InputObject  = [PSCustomObject] @{
                Property = 1
            };
            OutputObject = [Ordered] @{
                Property = 1
            };
        }
        @{
            InputObject  = [PSCustomObject] @{
                Property = "A"
            };
            OutputObject = [Ordered] @{
                Property = "A"
            };
        }
        @{
            InputObject  = [PSCustomObject] @{
                Property = @(1, 2)
            };
            OutputObject = [Ordered] @{
                Property = @(1, 2)
            };
        }
        @{
            InputObject  = [PSCustomObject] @{
                Property = @{Property1 = 1; Property2 = 2}
            };
            OutputObject = [Ordered] @{
                Property = @{Property1 = 1; Property2 = 2}
            };
        }
    ) {
        Param ($InputObject, $OutputObject)

        $Hashtable = Convert-PSCustomObjectToHashtable -InputObject $InputObject

        [String]::Compare(($Hashtable | ConvertTo-Json), ($OutputObject | ConvertTo-Json), $True) | Should Be 0
    }
}

Describe "Invoke-ExpressionSafe" {
    It "does not return output" {
        Invoke-ExpressionSafe -Command "Write-Output `"Host`"" | Should BeNullOrEmpty
    }

    It "returns output with WithHost flag" {
        Invoke-ExpressionSafe -Command "Write-Output `"Host`"" -WithHost | Should Be "Host"
    }

    It "throws on error" {
        {Invoke-ExpressionSafe -Command "Write-Error `"Error`""} | Should Throw
    }

    It "does not throw on error with Graceful flag" {
        {Invoke-ExpressionSafe -Command "Write-Error `"Error`"" -Graceful} | Should Not Throw
    }

    It "does not return error" {
        Invoke-ExpressionSafe -Command "Write-Error `"Error`"" -Graceful | Should BeNullOrEmpty
    }

    It "returns error with WithError flag" {
        Invoke-ExpressionSafe -Command "Write-Error `"Error`"" -Graceful -WithError | Should Match "^Invoke-ExpressionSafe : Error.*$"
    }
}

Describe "Merge-Objects" {
    It "merges two objects" {
        $Object1 = [PSCustomObject] @{
            1 = "A";
            2 = "B";
        }
        $Object2 = [PSCustomObject] @{
            2 = "C";
            3 = "D";
        }

        $Test = Merge-Objects -Object1 $Object1 -Object2 $Object2
        $Test.1 | Should Be "A"
        $Test.2 | Should Be "C"
        $Test.3 | Should Be "D"
    }
}

Describe "Read-FunctionNames" {
    $InputString = @"
Function A {}
Function B {}
Function C {}
"@

    It "returns function names" {
        $FunctionNames = Read-FunctionNames -InputString $InputString
        $FunctionNames[0] | Should Be "A"
        $FunctionNames[1] | Should Be "B"
        $FunctionNames[2] | Should Be "C"
    }
}

Describe "Read-PromptYesNo" {
    Context "Yes is selected" {
        Mock "Read-Prompt" {
            Return 0
        } -ModuleName "PowerShellLib"

        It "returns true" {
            Read-PromptYesNo -Caption "Test" -Message "Debug" | Should Be $True
        }
    }

    Context "No is selected" {
        Mock "Read-Prompt" {
            Return 1
        } -ModuleName "PowerShellLib"

        It "returns false" {
            Read-PromptYesNo -Caption "Test" -Message "Debug" | Should Be $False
        }
    }
}

Describe "Read-ValidInput" {
    Context "Input is valid" {
        Mock "Read-Host" {
            Return "abc"
        } -ModuleName "PowerShellLib"

        It "returns true" {
            Read-ValidInput -Prompt "Enter `"abc`"" -ValidityCheck @(
                {$args[0] -Match "^abc$"}
                {$args[0] -Match "^[a-z]{3}$"}
            ) -ErrorMessage @("Error", "Error") | Should Be $True
        }
    }

    Context "Parameter counts differ" {
        Mock "Read-Host" {
            Return "abc"
        } -ModuleName "PowerShellLib"

        It "throws" {
            { Read-ValidInput -Prompt "Enter `"abc`"" -ValidityCheck @(
                    {$Answer -Match "^abc$"}
                    {$Answer -Match "^[a-z]{3}$"}
                ) -ErrorMessage "Error"} | Should Throw "ValidityCheck and ErrorMessage count do not match!"
        }
    }
}

Describe "Test-EnvVarExists" {
    Context "Environment variable exists" {
        Mock "Get-ChildItem" {
            Return $True
        } -ModuleName "PowerShellLib"

        It "returns true" {
            Test-EnvVarExists -EnvVarName "Test" | Should Be $True
        }
    }

    Context "Environment variable does not exist" {
        Mock "Get-ChildItem" {
            Return $False
        } -ModuleName "PowerShellLib"

        It "returns false" {
            Test-EnvVarExists -EnvVarName "Test" | Should Be $False
        }
    }
}

Describe "Test-ModuleInstalled" {
    Context "Environment variable exists" {
        Mock "Get-Module" {
            Return $True
        } -ModuleName "PowerShellLib"

        It "returns true" {
            Test-ModuleInstalled -ModuleName "Test" | Should Be $True
        }
    }

    Context "Environment variable does not exist" {
        Mock "Get-Module" {
            Return $False
        } -ModuleName "PowerShellLib"

        It "returns false" {
            Test-ModuleInstalled -ModuleName "Test" | Should Be $False
        }
    }
}

Describe "Test-PropertyExists" {
    Context "Property exists" {
        It "returns true for <Object>" -TestCases @(
            @{
                Object       = [PSCustomObject] @{
                    "a" = 1
                    "b" = 2
                }
                PropertyName = @("a", "b")
            }
            @{
                Object       = [PSCustomObject] @{
                    "a" = [PSCustomObject] @{
                        "b" = 1
                    }
                }
                PropertyName = "a"
            }
            @{
                Object       = [PSCustomObject] @{
                    "a" = [PSCustomObject] @{
                        "b" = 1
                    }
                }
                PropertyName = "a.b"
            }
            @{
                Object       = @{
                    "a" = 1
                    "b" = 2
                }
                PropertyName = @("a", "b")
            }
            @{
                Object       = @{
                    "a" = @{
                        "b" = 1
                    }
                }
                PropertyName = "a"
            }
            @{
                Object       = @{
                    "a" = @{
                        "b" = 1
                    }
                }
                PropertyName = "a.b"
            }
        ) {
            Param (
                $Object,
                $PropertyName
            )

            Test-PropertyExists -Object $Object -PropertyName $PropertyName | Should Be $True
        }

        It "passes through the property" -TestCases @(
            @{
                Object       = [PSCustomObject] @{
                    "a" = 1
                    "b" = [PSCustomObject] @{
                        "c" = 2
                    }
                }
                PropertyName = @("a", "b.c")
            }
            @{
                Object       = @{
                    "a" = 1
                    "b" = @{
                        "c" = 2
                    }
                }
                PropertyName = @("a", "b.c")
            }
        ) {
            Param (
                $Object,
                $PropertyName
            )

            Test-PropertyExists -Object $Object -PropertyName $PropertyName -PassThrough | ConvertTo-Json | Should Be (@(@{ a = 1}, @{c = 2}) | ConvertTo-Json)
        }
    }

    Context "Property does not exist" {
        It "returns false for <Object>" -TestCases @(
            @{
                Object       = [PSCustomObject] @{
                    "a" = 1
                }
                PropertyName = @("a", "b")
            }
            @{
                Object       = [PSCustomObject] @{
                    "a" = [PSCustomObject] @{
                        "b" = 1
                    }
                }
                PropertyName = "b"
            }
            @{
                Object       = [PSCustomObject] @{
                    "a" = [PSCustomObject] @{
                        "b" = 1
                    }
                }
                PropertyName = "b"
            }
            @{
                Object       = [PSCustomObject] @{
                    "a" = [PSCustomObject] @{
                        "b" = 1
                    }
                }
                PropertyName = "a.c"
            }
            @{
                Object       = [PSCustomObject] @{
                    "a" = [PSCustomObject] @{
                        "b" = 1
                    }
                }
                PropertyName = "a.b.c"
            }
            @{
                Object       = @{
                    "a" = 1
                }
                PropertyName = @("a", "b")
            }
            @{
                Object       = @{
                    "a" = @{
                        "b" = 1
                    }
                }
                PropertyName = "b"
            }
            @{
                Object       = @{
                    "a" = @{
                        "b" = 1
                    }
                }
                PropertyName = "a.c"
            }
            @{
                Object       = @{
                    "a" = @{
                        "b" = 1
                    }
                }
                PropertyName = "a.b.c"
            }
        ) {
            Param (
                $Object,
                $PropertyName
            )

            Test-PropertyExists -Object $Object -PropertyName $PropertyName | Should Be $False
        }

        It "does not pass through the property" -TestCases @(
            @{
                Object       = [PSCustomObject] @{
                    "a" = 1
                }
                PropertyName = "b"
            }
            @{
                Object       = @{
                    "a" = 1
                }
                PropertyName = "b"
            }
        ) {
            Param (
                $Object,
                $PropertyName
            )

            Test-PropertyExists -Object $Object -PropertyName $PropertyName -PassThrough | Should Be $Null
        }
    }
}

Describe "Write-ErrorRecord" {
    It "returns an error record " {
        $ErrorVariable = $Null
        Write-ErrorRecord -Exception "Exception" -ErrorId "Exception" -ErrorCategory "NotSpecified" -TargetObject "TargetObject" -ErrorAction "SilentlyContinue" -ErrorVariable "ErrorVariable"
        $ErrorVariable[0].CategoryInfo.Reason | Should Be "Exception"
    }

    It "throws for unavailable exception" {
        {
            Write-ErrorRecord -Exception "ExceptionThatDoesNotExist" -ErrorId "Exception" -ErrorCategory "NotSpecified" -TargetObject "TargetObject" -WarningAction "SilentlyContinue"
        } | Should Throw "System.InvalidOperationException"
    }
}
