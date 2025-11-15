Set-Variable -Name ProfileDir -Value (Split-Path $Profile.CurrentUserCurrentHost)

if (Test-Path $ProfileDir) {
  Write-Warning "The profile directory already exists. Do nothing."
} else {
  if (Get-Command git) {
    New-Item $ProfileDir -ItemType Directory -Force | Out-Null
    Set-Location $ProfileDir
    git clone https://github.com/sebastianbrosch/powershell-profile.git .
    Write-Host "The profile has been successfully set up. Please restart PowerShell."
  } else {
    Write-Warning "Git is not installed. Do nothing."
  }
}
