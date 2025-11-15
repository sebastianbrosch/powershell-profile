Get-ChildItem ($(Join-Path $PSScriptRoot "Functions") + "/*.ps1") | ForEach-Object {
  . $_.FullName
} | Out-Null
