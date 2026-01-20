<#
.SYNOPSIS
Shows installed and available Windows optional features.

.DESCRIPTION
Shows a list of all installed and available Windows optional features on the system.
Features are sorted alphabetically by name. By default, the output is displayed as a list.
Use the -Table parameter to display features in an interactive grid view for easier browsing and filtering.

.PARAMETER Table
When specified, displays the Windows features in an interactive grid view window.
If not specified, features are returned as PowerShell objects to the pipeline.

.EXAMPLE
Show-WindowsFeatures
Displays all Windows features as a list.

.EXAMPLE
Show-WindowsFeatures -Table
Displays all Windows features in an interactive grid view for easy browsing.

.NOTES
Requires administrator privileges. The script will terminate if run without admin rights.
#>
function Show-WindowsFeatures {

  param (
    [Parameter(Mandatory=$false)]
    [switch] $Table
  )

  process {
    if (-not ([Security.Principal.WindowsIdentity]::GetCurrent().Groups -contains 'S-1-5-32-544')) {
      Write-Error "This script can only be run as an administrator."
      return
    }

    $features = Get-WindowsOptionalFeature -Online | Sort-Object -Property FeatureName

    if ($Table) {
      $features | Out-GridView -Wait -Title "Windows Features"
    } else {
      $features
    }
  }
}
