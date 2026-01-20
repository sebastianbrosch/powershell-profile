<#
.SYNOPSIS
Initializes Git configuration for the current repository using a predefined profile.

.DESCRIPTION
Initializes Git configuration for the current repository by loading settings from a predefined
profile stored in Git-Profiles.json. Configures user name, email, GPG signing key, and SSH key.
This enables automatic Git signing and SSH authentication for the repository.

.PARAMETER Email
The email address of the Git profile to load from Git-Profiles.json.
This parameter is used to match and retrieve the corresponding Git configuration.

.EXAMPLE
Initialize-GitConfig -Email "dev@example.com"

.NOTES
Requires Git to be installed and available in the system PATH.
Requires a Git-Profiles.json file in the Configurations directory containing profile definitions.
#>
function Initialize-GitConfig {
  [CmdletBinding()]

  param (
    [Parameter(Mandatory=$true)]
    [string] $Email
  )

  process {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
      Write-Error "Git is not available. Please make sure Git is installed."
      Write-Error "You can download Git here: https://git-scm.com/install/"
      return
    }

    $profileDirectory = Split-Path -Path $PSScriptRoot -Parent
    $configuration = Get-Content -Path (Join-Path -Path $profileDirectory -ChildPath "Configurations/Git-Profiles.json")
    $gitConfigurations = $configuration | ConvertFrom-Json
    $gitConfiguration = $gitConfigurations | Where-Object -Property 'email' -In $Email

    if ($null -eq $gitConfiguration) {
      Write-Warning "No Git configuration found."
      return
    }

    git config user.name $gitConfiguration.name
    git config user.email $gitConfiguration.email
    git config user.signingkey $gitConfiguration.signingkey
    git config commit.gpgsign true
    git config core.sshCommand "ssh -i ~/.ssh/$($gitConfiguration.sshfile)"

    Write-Verbose "Git configuration has been changed."
  }
}
