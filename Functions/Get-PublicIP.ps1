<#
.SYNOPSIS
Gets the public IP address.

.DESCRIPTION
Gets the public IP address using the ipify API.

.PARAMETER v4
A flag to get the public IPv4 address.

.PARAMETER v6
A flag to get the public IPv6 address.
#>
function Get-PublicIP {
  [CmdletBinding()]

  param (
    [switch] $v4,
    [switch] $v6
  )

  process {
    if ($v6) {
      (Invoke-WebRequest -Uri 'https://api6.ipify.org' -SkipHttpErrorCheck).Content
    } else {
      (Invoke-WebRequest -Uri 'https://api.ipify.org' -SkipHttpErrorCheck).Content
    }
  }
}

Set-Alias -Name Get-ExternalIP -Value Get-PublicIP
