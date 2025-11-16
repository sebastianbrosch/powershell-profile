<#
.SYNOPSIS
Initializes the Git configuration of a repository.

.DESCRIPTION
Initializes the Git configuration of a repository.

.PARAMETER Email
The email address of the Git profile.
#>
function Initialize-GitConfig {
  [CmdletBinding()]

  param (
    [Parameter(Mandatory=$true)]
    [string] $Email
  )

  Process {
    $ProfileDirectory = Split-Path -Path $PSScriptRoot -Parent
    $Configuration = Get-Content -Path (Join-Path -Path $ProfileDirectory -ChildPath "Configurations/Git-Profiles.json")
    $GitConfigurations = $Configuration | ConvertFrom-Json
    $GitConfiguration = $GitConfigurations | Where-Object -Property 'email' -In $Email

    if ($null -eq $GitConfiguration) {
      Write-Warning "No Git configuration found. Do nothing."
    } else {
      if (Get-Command git) {
        git config user.name $GitConfiguration.name
        git config user.email $GitConfiguration.email
        git config user.signingkey $GitConfiguration.signingkey
        git config commit.gpgsign true
        git config core.sshCommand "ssh -i ~/.ssh/$($GitConfiguration.sshfile)"
      } else {
        Write-Warning "Git is not installed. Do nothing."
      }
    }
  }
}
