<#
.SYNOPSIS
Starts a PowerShell with the specified architecture.

.DESCRIPTION
Starts a PowerShell with the specified architecture.

.PARAMETER Architecture
The architecture of the PowerShell that is to be started.
#>
function Start-PS {
  [CmdletBinding()]

  param (
    [Alias("A", "Arch")]
    [ValidateSet("x64", "x86", "X64", "X86")]
    [string] $Architecture = 'x64'
  )

  if ($Architecture.ToUpper() -eq 'X64') {
    Start-Process $($Env:SystemRoot + "\System32\WindowsPowerShell\v1.0\powershell.exe")
  } else {
    Start-Process $($Env:SystemRoot + "\SysWOW64\WindowsPowerShell\v1.0\powershell.exe")
  }
}

Set-Alias -Name Start-PowerShell -Value Start-PS
