[![Build status](https://ci.appveyor.com/api/projects/status/1h40wstbd2gssy57/branch/master?svg=true)](https://ci.appveyor.com/project/Dargmuesli/powershell-lib/branch/master)

# PowerShell-Lib
A library of helpful PowerShell functions.

## Installation
As this module is only available on GitHub, [PSDepend](https://github.com/RamblingCookieMonster/PSDepend) is needed to install it. If not yet done, have a look on [how to install PSDepend](https://github.com/RamblingCookieMonster/PSDepend#installing-psdepend) or just use these commands for PowerShell 5:

```PowerShell
Install-Module PSDepend -Scope "CurrentUser" -Force
Invoke-PSDepend @{"dargmuesli/powershell-lib"="latest"} -Install
```

PSDepend also allows other modules to depend on this one. Add the following line to your `Requirements.psd1` file:

```PowerShell
@{
    "dargmuesli/powershell-lib" = ""
}
```
