

param (
  [Parameter()] 
  [ValidateSet(1,2)]
  [Alias('User')]
  [Int] $PP_User = 1,
  [Parameter()]
  [ValidateSet(1,2)]
  [Alias('Host')]
  [Int] $PP_Host = 1
)

$SourceRoot = 'https://raw.githubusercontent.com/sebastianbrosch/powershell-profile/refs/heads/main/'
$ProfilePath = $PROFILE.CurrentUserCurrentHost

switch ("$PP_User$PP_Host") {
  '11' {
    $ProfilePath = $PROFILE.CurrentUserCurrentHost
  }
  '12' {
    $ProfilePath = $PROFILE.CurrentUserAllHosts
  }
  '21' {
    $ProfilePath = $PROFILE.AllUsersCurrentHost
  }
  '22' {
    $ProfilePath = $PROFILE.AllUsersAllHosts
  }
}

switch ($ProfilePath) {
  $PROFILE.CurrentUserCurrentHost {
    $ProfileName = 'Current User, Current Host'
  }
  $PROFILE.CurrentUserAllHosts {
    $ProfileName = 'Current User, All Hosts'
  }
  $PROFILE.AllUsersCurrentHost {
    $ProfileName = 'All Users, Current Host'
  }
  $PROFILE.AllUsersAllHosts {
    $ProfileName = 'All Users, All Hosts'
  }
  default {
    Write-Host 'This profile path is not known.'
    Exit 1
  }
}

$ProfileFolder = Split-Path $ProfilePath

$files = @(
  "Modules/PowerShell.psm1",
  "Modules/Utils.psm1"
)

if (!(Test-Path -Path $ProfilePath)) {
  Write-Host -ForegroundColor Green "Installing the PowerShell profile: $ProfileName"
  Import-Module BitsTransfer
  Start-BitsTransfer -Source "${SourceRoot}Profile.ps1" -Destination $ProfilePath

  foreach ($file in $files) {
    Start-BitsTransfer -Source "${SourceRoot}${file}" -Destination $(Join-Path -Path $ProfileFolder -ChildPath $file)
  }
} else {
  Write-Host -ForegroundColor Yellow "The PowerShell profile $ProfileName is already installed."
}