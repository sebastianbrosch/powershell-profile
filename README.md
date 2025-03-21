# PowerShell Profile
A PowerShell profile to extend a PowerShell session with additional scripts and modules.

**USE THIS SCRIPT AT YOUR OWN RISK.**

## Scripts

- `Get-GUID`: Gets a random Globally Unique Identifier (GUID).

## Install
You can install this PowerShell profile by using the following command in a PowerShell session:

```
Set-ExecutionPolicy Bypass -Scope Process -Force;[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls13; try { & ([ScriptBlock]::Create((Invoke-WebRequest https://raw.githubusercontent.com/sebastianbrosch/powershell-profile/refs/heads/main/Install-PP_Profile.ps1)))} catch { Write-Error $_ }
```