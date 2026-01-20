<#
.SYNOPSIS
Retrieves the public IP address (IPv4 or IPv6).

.DESCRIPTION
Retrieves the public IP address by querying the ipify API service.
By default, both IPv4 and IPv6 addresses are returned if available.
Use -V4 or -V6 to get a specific IP version.

.PARAMETER V4
When specified, retrieves only the public IPv4 address.

.PARAMETER V6
When specified, retrieves only the public IPv6 address.

.EXAMPLE
Get-PublicIP
Returns both IPv4 and IPv6 addresses if available.

.EXAMPLE
Get-PublicIP -V4
Returns only the public IPv4 address.

.EXAMPLE
Get-PublicIP -V6
Returns only the public IPv6 address.

.NOTES
Requires internet connectivity to reach the ipify API service.
#>
function Get-PublicIP {
  [CmdletBinding()]

  param (
    [switch] $V4,
    [switch] $V6
  )

  process {
    if (-not $V4 -and -not $V6) {
      $V4 = $true
      $V6 = $true
    }

    if ($V4) {
      (Invoke-WebRequest -Uri 'https://api.ipify.org' -SkipHttpErrorCheck).Content
    }

    if ($V6) {
      (Invoke-WebRequest -Uri 'https://api6.ipify.org' -SkipHttpErrorCheck).Content
    }
  }
}

Set-Alias -Name Get-ExternalIP -Value Get-PublicIP
