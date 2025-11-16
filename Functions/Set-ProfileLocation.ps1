<#
.SYNOPSIS
Sets the current location to the profile directory.

.DESCRIPTION
Sets the current location to the profile directory.
#>
function Set-ProfileLocation {
  Set-Location (Split-Path -Path $PROFILE.CurrentUserCurrentHost -Parent)
}
