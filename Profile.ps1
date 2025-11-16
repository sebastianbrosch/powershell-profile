function prompt {
  $currentDateTime = $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
  $currentLocation = $(Get-Location).Path
  Write-Host "[$($currentDateTime)] $($currentLocation)\>" -NoNewline -ForegroundColor White
  return " "
}

Get-ChildItem ($(Join-Path $PSScriptRoot "Functions") + "/*.ps1") | ForEach-Object {
  . $_.FullName
} | Out-Null
