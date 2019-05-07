Write-Host "PowerShell Version: $(${PSVersionTable}.PSVersion)"

Install-Module -Name "Pester" -SkipPublisherCheck -Scope "CurrentUser" -Force