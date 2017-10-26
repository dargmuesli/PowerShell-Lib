[![Build status](https://ci.appveyor.com/api/projects/status/1h40wstbd2gssy57/branch/master?svg=true)](https://ci.appveyor.com/project/Dargmuesli/powershell-lib/branch/master)

# PowerShell-Lib
A library of helpful PowerShell functions.

## Installation
As this module is only available on GitHub, [PSDepend](https://github.com/RamblingCookieMonster/PSDepend) is needed to install it. If not yet done, have a look on [how to install PSDepend](https://github.com/RamblingCookieMonster/PSDepend#installing-psdepend) or just use these commands for PowerShell 5:

```PowerShell
    Install-Module PSDepend -Scope CurrentUser
    Invoke-PSDepend @{"dargmuesli/powershell-lib"=""} -Install
```

PSDepend also allows other modules to depend on this one. Add the following line to your `Requirements.psd1` file:

```PowerShell
@{
    "dargmuesli/powershell-lib" = ""
}
```

## Modules
- **AppLib**
  - [Get-AppsInstalled](PowerShell-Lib/Docs/Get-AppsInstalled.md)
  - [Install-App](PowerShell-Lib/Docs/Install-App.md)
  - [Test-AppInstalled](PowerShell-Lib/Docs/Test-AppInstalled.md)
- **DockerLib**
  - [Clear-DockerMachineEnv](PowerShell-Lib/Docs/Clear-DockerMachineEnv.md)
  - [Get-DockerEditionToUse](PowerShell-Lib/Docs/Get-DockerEditionToUse.md)
  - [Get-DockerMachineStatus](PowerShell-Lib/Docs/Get-DockerMachineStatus.md)
  - [Install-Docker](PowerShell-Lib/Docs/Install-Docker.md)
  - [Invoke-Docker](PowerShell-Lib/Docs/Invoke-Docker.md)
  - [Invoke-DockerMachine](PowerShell-Lib/Docs/Invoke-DockerMachine.md)
  - [New-DockerMachine](PowerShell-Lib/Docs/New-DockerMachine.md)
  - [Set-DockerMachineEnv](PowerShell-Lib/Docs/Set-DockerMachineEnv.md)
  - [Start-Docker](PowerShell-Lib/Docs/Start-Docker.md)
  - [Start-DockerMachine](PowerShell-Lib/Docs/Start-DockerMachine.md)
  - [Start-DockerRegistry](PowerShell-Lib/Docs/Start-DockerRegistry.md)
  - [Stop-DockerMachine](PowerShell-Lib/Docs/Stop-DockerMachine.md)
  - [Stop-DockerStack](PowerShell-Lib/Docs/Stop-DockerStack.md)
  - [Test-DockerForWinInstalled](PowerShell-Lib/Docs/Test-DockerForWinInstalled.md)
  - [Test-DockerInstalled](PowerShell-Lib/Docs/Test-DockerInstalled.md)
  - [Test-DockerInSwarm](PowerShell-Lib/Docs/Test-DockerInSwarm.md)
  - [Test-DockerMachineEnvExists](PowerShell-Lib/Docs/Test-DockerMachineEnvExists.md)
  - [Test-DockerMachineExists](PowerShell-Lib/Docs/Test-DockerMachineExists.md)
  - [Test-DockerRegistryRunning](PowerShell-Lib/Docs/Test-DockerRegistryRunning.md)
  - [Test-DockerRunning](PowerShell-Lib/Docs/Test-DockerRunning.md)
  - [Test-DockerStackRunning](PowerShell-Lib/Docs/Test-DockerStackRunning.md)
  - [Test-DockerToolboxInstalled](PowerShell-Lib/Docs/Test-DockerToolboxInstalled.md)
  - [Write-DockerComposeFile](PowerShell-Lib/Docs/Write-DockerComposeFile.md)
- **JavaLib**
  - [Test-JDKInstalled](PowerShell-Lib/Docs/Test-JDKInstalled.md)
  - [Test-JREInstalled](PowerShell-Lib/Docs/Test-JREInstalled.md)
- **PowerShellLib**
  - [Add-Package](PowerShell-Lib/Docs/Add-Package.md)
  - [Convert-PSCustomObjectToHashtable](PowerShell-Lib/Docs/Convert-PSCustomObjectToHashtable.md)
  - [Get-FileFromWeb](PowerShell-Lib/Docs/Get-FileFromWeb.md)
  - [Initialize-TaskPath](PowerShell-Lib/Docs/Initialize-TaskPath.md)
  - [Install-ModuleOnce](PowerShell-Lib/Docs/Install-ModuleOnce.md)
  - [Install-PackageOnce](PowerShell-Lib/Docs/Install-PackageOnce.md)
  - [Invoke-ExpressionSafe](PowerShell-Lib/Docs/Invoke-ExpressionSafe.md)
  - [Invoke-WebRequestWithProgress](PowerShell-Lib/Docs/Invoke-WebRequestWithProgress.md)
  - [Merge-Objects](PowerShell-Lib/Docs/Merge-Objects.md)
  - [Mount-EnvFile](PowerShell-Lib/Docs/Mount-EnvFile.md)
  - [Read-FunctionNames](PowerShell-Lib/Docs/Read-FunctionNames.md)
  - [Read-Prompt](PowerShell-Lib/Docs/Read-Prompt.md)
  - [Read-PromptYesNo](PowerShell-Lib/Docs/Read-PromptYesNo.md)
  - [Set-ArrayItem](PowerShell-Lib/Docs/Set-ArrayItem.md)
  - [Test-EnvVarExists](PowerShell-Lib/Docs/Test-EnvVarExists.md)
  - [Test-ModuleInstalled](PowerShell-Lib/Docs/Test-ModuleInstalled.md)
  - [Test-PropertyExists](PowerShell-Lib/Docs/Test-PropertyExists.md)
  - [Wait-Test](PowerShell-Lib/Docs/Wait-Test.md)
  - [Write-ProgressBar](PowerShell-Lib/Docs/Write-ProgressBar.md)
- **ProjectLib**
  - [New-ModuleMarkdown](PowerShell-Lib/Docs/New-ModuleMarkdown.md)
  - [Read-Settings](PowerShell-Lib/Docs/Read-Settings.md)
- **SystemLib**
  - [Get-DownloadFolder](PowerShell-Lib/Docs/Get-DownloadFolder.md)
  - [Get-SystemBit](PowerShell-Lib/Docs/Get-SystemBit.md)
- **TextLib**
  - [Clear-Linebreaks](PowerShell-Lib/Docs/Clear-Linebreaks.md)
  - [Join-MultiLineStrings](PowerShell-Lib/Docs/Join-MultiLineStrings.md)
- **ValidationLib**
  - [Test-Command](PowerShell-Lib/Docs/Test-Command.md)
  - [Test-CountValid](PowerShell-Lib/Docs/Test-CountValid.md)
  - [Test-HostnameValid](PowerShell-Lib/Docs/Test-HostnameValid.md)
  - [Test-IPAddressValid](PowerShell-Lib/Docs/Test-IPAddressValid.md)
  - [Test-IRIValid](PowerShell-Lib/Docs/Test-IRIValid.md)
  - [Test-LengthValid](PowerShell-Lib/Docs/Test-LengthValid.md)
  - [Test-NotNullOrEmptyValid](PowerShell-Lib/Docs/Test-NotNullOrEmptyValid.md)
  - [Test-NotNullValid](PowerShell-Lib/Docs/Test-NotNullValid.md)
  - [Test-PathValid](PowerShell-Lib/Docs/Test-PathValid.md)
  - [Test-PatternValid](PowerShell-Lib/Docs/Test-PatternValid.md)
  - [Test-PortValid](PowerShell-Lib/Docs/Test-PortValid.md)
  - [Test-RangeValid](PowerShell-Lib/Docs/Test-RangeValid.md)
  - [Test-ScriptValid](PowerShell-Lib/Docs/Test-ScriptValid.md)
  - [Test-SetValid](PowerShell-Lib/Docs/Test-SetValid.md)
  - [Test-TypeValid](PowerShell-Lib/Docs/Test-TypeValid.md)
- **YamlDotNetLib**
  - [New-DoubleQuotedString](PowerShell-Lib/Docs/New-DoubleQuotedString.md)
  - [New-Yaml](PowerShell-Lib/Docs/New-Yaml.md)
